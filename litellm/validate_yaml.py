#!/usr/bin/env python3

import sys
import yaml
import json

def validate_yaml(file_path):
    """Validate YAML file and print detailed error information if invalid."""
    try:
        with open(file_path, 'r') as file:
            yaml_content = file.read()
            print(f"YAML content:\n{yaml_content}")

            # Try to parse it
            data = yaml.safe_load(yaml_content)
            print("\nSuccessfully parsed as YAML")

            # Output the parsed structure
            print("\nParsed structure:")
            print(json.dumps(data, indent=2))
            return True
    except Exception as e:
        print(f"\nError parsing YAML: {type(e).__name__}: {e}")
        # Try to show the exact line that failed
        if hasattr(e, 'problem_mark'):
            mark = e.problem_mark
            print(f"Error position: line {mark.line + 1}, column {mark.column + 1}")
        return False

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <yaml_file>")
        sys.exit(1)

    file_path = sys.argv[1]
    if not validate_yaml(file_path):
        sys.exit(1)
