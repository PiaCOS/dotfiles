#!/usr/bin/env python3

import shlex
import signal
import subprocess
import sys
import time
from argparse import ArgumentParser, BooleanOptionalAction, Namespace
from dataclasses import dataclass
from typing import Optional, TypeAlias
from pathlib import Path

COMMUNITY_PATH = "./community"
COMMUNITY_ADDONS_PATH = "addons/"
ENTERPRISE_PATH = "../enterprise"

HELPER = """
COMMANDS:
    --addons "addons/,../enterprise"   <-- default = "addons/"
    -e                                 <-- loads enterprise addons
    --dev all                          <-- default = xml,qweb (= all w/o 'reload' and 'access')
    -p 8869                            <-- default = 8869
    -c "./community"                   <-- default = "COMMUNITY_PATH"
    -d default_db                      <-- default = default_db
    -i 'marketing_automation,sign'     <-- default = None
    -u 'marketing_automation,sign'     <-- default = None
    --test [/module][:class][.method]  <-- default = None
    --log                              <-- default = info (warn, critical, error, test, debug, debug_sql)
    --demo                             => load demo data
    --log_sql                          => activate SQL log
    --shell                            => activate shell mode
    --dry                              => activate dry run mode
    --out                              => return the full command (useful to copy paste)
    --need_help                        => guess you already found this one
"""


# -------- TYPES --------

Args: TypeAlias = Namespace

@dataclass
class ArgField:
    name: str
    dest: str
    default: Optional[str|int]

@dataclass
class ArgFlag:
    name: str
    dest: str
    default: bool


# -------- ARGS --------

addons =     COMMUNITY_ADDONS_PATH
dev =        "xml,qweb"
port =       8869
db =         "default_db"
cwd =        COMMUNITY_PATH
log =        "info"
workers =    0
to_install = None
to_update =  None
to_test =    None

arg_list = [
    ArgField( "--addons",      "addons",          None ),
    ArgField( "--dev",         "dev",             dev ),
    ArgField( "-p",            "port",            port ),
    ArgField( "-d",            "db",              db ),
    ArgField( "-c",            "cwd",             cwd ),
    ArgField( "-i",            "to_install",      to_install ),
    ArgField( "-u",            "to_update",       to_update ),
    ArgField( "--workers",     "workers",         workers ),
    ArgField( "--test",        "to_test",         to_test ),
    ArgField( "--log",         "log",             log ),
    ArgField( "--db_host",     "db_host",         "localhost" ),
    ArgField( "--db_user",     "db_user",         "odoo" ),
    ArgField( "--db_password", "db_password",     "odoo" ),
    ArgFlag( "-e",             "use_enterprise",  False ),
    ArgFlag( "--demo",         "with_demo",       False ),
    ArgFlag( "--log_sql",      "log_sql",         False ),
    ArgFlag( "--shell",        "shell_mode",      False ),
    ArgFlag( "--dry",          "dry_run",         False ),
    ArgFlag( "--out",          "out",             False ),
    ArgFlag( "--need_help",    "need_help",       False ),
]


def parse(args: list[ArgField|ArgFlag]) -> Args:
    parser = ArgumentParser(description="odoo tooling")
    for arg in args:
        action = BooleanOptionalAction if isinstance(arg, ArgFlag) else "store"
        parser.add_argument(arg.name, action=action, dest=arg.dest, default=arg.default)
    return parser.parse_args()

args = parse(arg_list)


# -------- EXEC --------

def run_command(command: str, args: Args) -> None:
    proc = subprocess.Popen(shlex.split(command), cwd=args.cwd)
    try:
        proc.wait()
    except KeyboardInterrupt:
        print("-- KeyboardInterrupt --")
        try:
            proc.send_signal(signal.SIGINT)
        except ProcessLookupError:
            pass
        try:
            proc.wait(timeout=2)
        except subprocess.TimeoutExpired:
            proc.kill()
        time.sleep(0.2)
        sys.exit(130)


# -------- MAIN --------

def addons_path(args: Args) -> Path:
    addons_path = addons
    if args.addons:
        return Path(args.addons)
    elif args.use_enterprise:
        addons_path += f",{ENTERPRISE_PATH}"
    return Path(addons_path)


def main():
    mode = "shell" if args.shell_mode else "server"

    if not args.need_help:
        print("sys.executable: ", sys.executable)
        command = f"{sys.executable} ./odoo-bin --addons-path={addons_path(args)} {mode} --dev={args.dev} --http-port={args.port} -d {args.db} --log-level={args.log}"
        command += f" --db_host={args.db_host} --db_user={args.db_user} --db_password={args.db_password} --workers={args.workers}"
        if args.to_install:
            command += f" -i {args.to_install}"
        if args.to_update:
            command += f" -u {args.to_update}"
        if args.to_test:
            command += f" --test-tags {args.to_test}"
        if args.log_sql:
            command += " --log-sql"
        if args.with_demo:
            command += " --with-demo"

        if args.dry_run:
            print(f"DRY-RUN:\n> cd {args.cwd}\n> {command}\n")
            user_input = input("Do you want to continue? ([y]es, [n]o):\n")
            if user_input.lower() not in ["yes", "y"]:
                print("Exiting...")
                return
            else:
                print("Continuing...")

        if args.out:
            print(command)
            return

        print(f"Running on port {args.port}...")
        run_command(command, args)
    else:
        print(HELPER)

if __name__ == "__main__":
    main()
