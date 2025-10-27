#!/usr/bin/python3

import shlex
import signal
import subprocess
import sys
import time
from argparse import ArgumentParser, BooleanOptionalAction, Namespace
from dataclasses import dataclass
from typing import Optional


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

addons =     "addons/,../enterprise/"
dev =        "xml,qweb"
port =       8869
db =         "default_db"
cwd =        "./community"
log =        "info"
to_install = None
to_update =  None
to_test =    None

arg_list = [
    ArgField( "--addons",   "addons",     addons ),
    ArgField( "--dev",      "dev",        dev ),
    ArgField( "-p",         "port",       port ),
    ArgField( "-d",         "db",         db ),
    ArgField( "-c",         "cwd",        cwd ),
    ArgField( "-i",         "to_install", to_install ),
    ArgField( "-u",         "to_update",  to_update ),
    ArgField( "--test",     "to_test",    to_test ),
    ArgField( "--log",      "log"    ,    log ),
    ArgFlag( "--demo",      "with_demo",  False ),
    ArgFlag( "--log_sql",   "log_sql",    False ),
    ArgFlag( "--shell",     "shell_mode", False ),
    ArgFlag( "--dry",       "dry_run",    False ),
    ArgFlag( "--out",       "out",    False ),
    ArgFlag( "--need_help", "need_help",  False ),
]

def parse(args: list[ArgField|ArgFlag]) -> Namespace:
    parser = ArgumentParser(description="odoo tooling")
    for arg in args:
        action = BooleanOptionalAction if isinstance(arg, ArgFlag) else "store"
        parser.add_argument(arg.name, action=action, dest=arg.dest, default=arg.default)
    return parser.parse_args()

args = parse(arg_list)


# -------- EXEC --------

def run_command(command, args):
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

def main():
    mode = "shell" if args.shell_mode else "server"

    if not args.need_help:
        command = f"./odoo-bin --addons-path={args.addons} {mode} --dev={args.dev} --http-port={args.port} -d {args.db} --log-level={args.log}"
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
        print(
            """
COMMANDS:
    --addons "addons/,../enterprise"   <-- default = "addons/,../enterprise/"
    --dev all                          <-- default = xml,qweb (= all w/o 'reload' and 'access')
    -p 8869                            <-- default = 8869
    -c "./community"                   <-- default = "./community" 
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
        )

if __name__ == "__main__":
    main()
