# ai-voice

Voice cloning TTS powered by [Coqui XTTS v2](https://github.com/coqui-ai/TTS).  
Generate speech from text using a short sample of any voice.

---

## English

### Requirements

- macOS
- Internet connection (for first-time model download ~2 GB)

### Setup

#### Option A: Using Git (Recommended)
```bash
git clone https://github.com/akovall/ai-voice.git
cd ai-voice
```

#### Option B: Download ZIP (Without Git)
1. Download the [ZIP archive](https://github.com/akovall/ai-voice/archive/refs/heads/main.zip) and extract it.
2. Open Terminal and navigate to the extracted folder:
   ```bash
   cd ai-voice-main
   ```

#### Run Installation
Once inside the folder, run:
```bash
chmod +x setup.sh
./setup.sh
```

The script will automatically install Homebrew (if missing), Python 3.11, and all required dependencies into a local virtual environment (`xtts-env/`).

### Usage

1. Activate the virtual environment:
   ```bash
   source xtts-env/bin/activate
   ```

2. Put your text into `text.txt` (or any `.txt` file).

3. Provide a voice sample — a short WAV file of the voice you want to clone (default: `my_voice.wav`).

4. Generate speech:
   ```bash
   python speak.py text.txt
   ```

   **Options:**
   | Flag | Default | Description |
   |------|---------|-------------|
   | `--voice` | `my_voice.wav` | Path to the voice sample WAV file |
   | `--out` | `output.wav` | Path for the output audio file |
   | `--lang` | `en` | Language code (`en`, `ru`, `de`, etc.) |

   **Example:**
   ```bash
   python speak.py text.txt --voice my_voice.wav --out result.wav --lang en
   ```

> **Note:** The XTTS v2 model (~2 GB) is downloaded automatically on first run.

---

## Русский

### Требования

- macOS
- Интернет-соединение (для первой загрузки модели ~2 ГБ)

### Установка

#### Вариант А: Через Git (Рекомендуется)
```bash
git clone https://github.com/akovall/ai-voice.git
cd ai-voice
```

#### Вариант Б: Скачать ZIP (Без Git)
1. Скачайте [ZIP-архив](https://github.com/akovall/ai-voice/archive/refs/heads/main.zip) и распакуйте его.
2. Откройте Терминал и перейдите в папку с проектом:
   ```bash
   cd ai-voice-main
   ```

#### Запуск установки
Находясь в папке проекта, выполните:
```bash
chmod +x setup.sh
./setup.sh
```

Скрипт автоматически установит Homebrew (если его нет), Python 3.11 и все необходимые зависимости в локальное виртуальное окружение (`xtts-env/`).

### Использование

1. Активируйте виртуальное окружение:
   ```bash
   source xtts-env/bin/activate
   ```

2. Запишите текст в `text.txt` (или любой другой `.txt` файл).

3. Подготовьте образец голоса — короткий WAV-файл с голосом, который нужно клонировать (по умолчанию: `my_voice.wav`).

4. Сгенерируйте речь:
   ```bash
   python speak.py text.txt
   ```

   **Параметры:**
   | Флаг | По умолчанию | Описание |
   |------|--------------|----------|
   | `--voice` | `my_voice.wav` | Путь к WAV-файлу с образцом голоса |
   | `--out` | `output.wav` | Путь для выходного аудиофайла |
   | `--lang` | `en` | Код языка (`en`, `ru`, `de` и др.) |

   **Пример:**
   ```bash
   python speak.py text.txt --voice my_voice.wav --out result.wav --lang ru
   ```

> **Примечание:** Модель XTTS v2 (~2 ГБ) загружается автоматически при первом запуске.
