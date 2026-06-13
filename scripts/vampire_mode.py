import evdev
from evdev import InputDevice, ecodes

# Your specific keyboard path
path = '/dev/input/by-path/platform-i8042-serio-0-event-kbd'

# Physical AZERTY mapping:
# Physical 'Z' is KEY_W, Physical 'Q' is KEY_A
mapping = {
    ecodes.KEY_W: ecodes.KEY_UP,
    ecodes.KEY_A: ecodes.KEY_LEFT,
    ecodes.KEY_S: ecodes.KEY_DOWN,
    ecodes.KEY_D: ecodes.KEY_RIGHT,
}

try:
    dev = InputDevice(path)
    ui = evdev.UInput()

    print("Vampire Mode: ON (ZQSD -> Arrows)")
    print("Press Ctrl+C to exit and return to typing.")

    # Grab prevents the 'z' 'q' 's' 'd' letters from appearing in your terminal/game chat
    dev.grab()

    for event in dev.read_loop():
        if event.type == ecodes.EV_KEY:
            if event.code in mapping:
                # Send the arrow key instead
                ui.write(ecodes.EV_KEY, mapping[event.code], event.value)
                ui.syn()
            else:
                # Pass everything else through normally
                ui.write(ecodes.EV_KEY, event.code, event.value)
                ui.syn()
except KeyboardInterrupt:
    print("\nExiting... Keyboard returned to normal.")
except PermissionError:
    print("\nError: You need to run this with sudo!")
finally:
    try:
        dev.ungrab()
    except:
        pass
