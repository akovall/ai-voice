import argparse
from pathlib import Path
from TTS.api import TTS


MODEL_NAME = "tts_models/multilingual/multi-dataset/xtts_v2"


def main():
    parser = argparse.ArgumentParser(description="XTTS v2 voice cloning TTS")
    parser.add_argument("text_file", help="A text file, for example text.txt")
    parser.add_argument("--voice", default="my_voice.wav", help="A voice file, for example my_voice.wav")
    parser.add_argument("--out", default="output.wav", help="A path to save the result, for example output.wav")
    parser.add_argument("--lang", default="en", help="Language: ru, en, de, etc.")
    
    args = parser.parse_args()

    text_path = Path(args.text_file)
    voice_path = Path(args.voice)

    if not text_path.exists():
        raise FileNotFoundError(f"No text file found: {text_path}")

    if not voice_path.exists():
        raise FileNotFoundError(f"No voice file found: {voice_path}")

    text = text_path.read_text(encoding="utf-8").strip()

    if not text:
        raise ValueError("The text file is empty")

    print("Loading XTTS v2...")
    tts = TTS(model_name=MODEL_NAME)

    print("Generating audio...")
    tts.tts_to_file(
        text=text,
        speaker_wav=str(voice_path),
        language=args.lang,
        file_path=args.out
    )

    print(f"Done: {args.out}")


if __name__ == "__main__":
    main()