#!/usr/bin/env python3
import subprocess

def show_routes(ns):
    print(f"--- Routes in {ns} ---")
    output = subprocess.check_output(["ip", "netns", "exec", ns, "ip", "route"]).decode()
    print(output)

def main():
    print("Analyzing simulated routing tables...")
    show_routes("R1")
    show_routes("R2")

if __name__ == "__main__":
    main()
