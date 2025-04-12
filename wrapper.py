import os
import argparse
from pose_estimation import main as process_video


def is_video_file(filename):
    """Check if a file is a video file based on its extension"""
    video_extensions = [".mp4", ".avi", ".mov", ".mkv", ".flv", ".wmv"]
    return any(filename.lower().endswith(ext) for ext in video_extensions)


def find_video_files(directory, recursive=False):
    """Find all video files in a directory, optionally searching recursively"""
    video_files = []

    if recursive:
        # Walk through all subdirectories
        for root, dirs, files in os.walk(directory):
            for file in files:
                if is_video_file(file):
                    # Store full path and relative path for directory structure preservation
                    rel_dir = os.path.relpath(root, directory)
                    if rel_dir == ".":
                        video_files.append((file, "", os.path.join(root, file)))
                    else:
                        video_files.append((file, rel_dir, os.path.join(root, file)))
    else:
        # Only look in the top-level directory
        for file in os.listdir(directory):
            file_path = os.path.join(directory, file)
            if os.path.isfile(file_path) and is_video_file(file):
                video_files.append((file, "", file_path))

    return video_files


def process_directory(input_dir, output_dir, model_path, recursive=False):
    """Process all video files in the input directory"""
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)

    # Get all video files in the input directory
    video_files = find_video_files(input_dir, recursive)

    if not video_files:
        print(f"No video files found in {input_dir}")
        return

    print(f"Found {len(video_files)} video files in {input_dir}")

    # Process each video file
    for i, (filename, rel_dir, file_path) in enumerate(video_files):
        print(f"\nProcessing video {i + 1}/{len(video_files)}: {filename}")

        # Create subdirectory in output directory if needed
        if rel_dir:
            current_output_dir = os.path.join(output_dir, rel_dir)
            os.makedirs(current_output_dir, exist_ok=True)
        else:
            current_output_dir = output_dir

        # Call the main function from hand_landmark_processor.py
        process_video(file_path, model_path, current_output_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Process all video files in a directory to extract hand landmarks."
    )
    parser.add_argument(
        "--input_dir",
        type=str,
        required=True,
        help="Directory containing video files to process",
    )
    parser.add_argument(
        "--output_dir",
        type=str,
        required=True,
        help="Directory to save output JSON files",
    )
    parser.add_argument(
        "--model_path",
        type=str,
        required=True,
        help="Path to the MediaPipe hand landmarker model",
    )
    parser.add_argument(
        "--recursive",
        action="store_true",
        help="Process video files in subdirectories recursively",
    )

    args = parser.parse_args()

    process_directory(args.input_dir, args.output_dir, args.model_path, args.recursive)
