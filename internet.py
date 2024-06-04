import os
import time
import subprocess

# Ping function
def ping(host):
    # Use the ping command
    response = subprocess.run(
        ['ping', '-c', '1', host],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    if response.returncode == 0:
        # Extract the ping time
        output = response.stdout.decode()
        time_index = output.find('time=')
        if time_index != -1:
            ping_time = float(output[time_index+5:].split(' ')[0])
            return True, ping_time
    return False, None

# Log function
def log_event(event):
    with open("ping_log.txt", "a") as log_file:
        log_file.write(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - {event}\n")

# Main loop
def monitor_ping():
    host = "8.8.8.8"
    failed_pings = 0
    in_failure = False
    failure_start = None

    while True:
        success, ping_time = ping(host)
        if success:
            print(f"Ping successful: {ping_time} ms")
        else:
            print("Ping failed")

        if not success or ping_time > 300:
            failed_pings += 1
            if failed_pings >= 2 and not in_failure:
                failure_start = time.strftime('%Y-%m-%d %H:%M:%S')
                log_event(f"Ping failure started at {failure_start}")
                print(f"Ping failure started at {failure_start}")
                in_failure = True
        else:
            if in_failure:
                recovery_time = time.strftime('%Y-%m-%d %H:%M:%S')
                duration = (time.mktime(time.strptime(recovery_time, '%Y-%m-%d %H:%M:%S')) -
                            time.mktime(time.strptime(failure_start, '%Y-%m-%d %H:%M:%S')))
                log_event(f"Ping failure recovered at {recovery_time} after {duration:.2f} seconds")
                print(f"Ping failure recovered at {recovery_time} after {duration:.2f} seconds")
                in_failure = False
            failed_pings = 0

        time.sleep(1)

if __name__ == "__main__":
    monitor_ping()
