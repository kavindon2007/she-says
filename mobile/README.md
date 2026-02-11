# Girl Dropout Risk Analysis - Flutter Mobile App

## 🚀 Setup Instructions

### Prerequisites
1. **Install Flutter SDK** (3.0.0 or higher)
   - Download from: https://docs.flutter.dev/get-started/install
   - Verify installation: `flutter doctor`

2. **Android Studio** or **VS Code** with Flutter extensions

### Initial Setup

1. **Navigate to mobile directory:**
   ```bash
   cd "/Users/s.kavin/Desktop/shesays 3/mobile"
   ```

2. **Create Flutter project structure:**
   ```bash
   flutter create --org com.shestays --project-name girl_dropout_mobile .
   ```
   
   When prompted, choose:
   - Platform: Android
   - Language: Dart

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Generate Freezed code:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Model Setup (Gemma 2B)

1. **Download the model:**
   - Model: Gemma 2B IT (4-bit GPU quantized)
   - Size: ~1.5GB
   - Download from: https://ai.google.dev/gemma/docs/get_started

2. **Place model on device:**
   ```bash
   adb push gemma-2b-it-gpu-int4.bin /data/local/tmp/
   ```

3. **Verify model path:**
   ```bash
   adb shell ls -lh /data/local/tmp/gemma-2b-it-gpu-int4.bin
   ```

### Android Configuration

1. **Update `android/app/build.gradle`:**
   ```gradle
   android {
       compileSdkVersion 34
       
       defaultConfig {
           minSdkVersion 24  // Required for MediaPipe
           targetSdkVersion 34
       }
   }
   ```

2. **Add permissions in `android/app/src/main/AndroidManifest.xml`:**
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

### Running the App

1. **Connect Android device or start emulator**

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **For release build:**
   ```bash
   flutter build apk --release
   ```

## 📁 Project Structure

```
mobile/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── models/
│   │   ├── student.dart             # Student data model
│   │   ├── student.freezed.dart     # Generated
│   │   ├── student.g.dart           # Generated
│   │   ├── class_data.dart          # Class model
│   │   ├── class_data.freezed.dart  # Generated
│   │   └── class_data.g.dart        # Generated
│   ├── providers/
│   │   ├── class_provider.dart      # Class state management
│   │   └── slm_provider.dart        # AI inference provider
│   ├── services/
│   │   ├── database_service.dart    # SQLite operations
│   │   └── slm_service.dart         # On-device AI
│   └── widgets/
│       ├── class_risk_card.dart     # Expandable card
│       ├── class_insights_tab.dart  # Charts & AI analysis
│       └── student_list_tab.dart    # Student list
└── pubspec.yaml                     # Dependencies
```

## 🔑 Key Features

### Privacy-First UI
- **Collapsed State**: Shows only class name (no sensitive data)
- **Expanded State**: Full details with tabs (Class Insights, Student List)
- **Lazy Loading**: Students loaded only when card expands

### On-Device AI
- **Model**: Gemma 2B (4-bit quantized)
- **Inference**: Runs in Isolate (background thread)
- **Fallback**: Rules-based analysis if AI unavailable
- **Privacy**: All processing happens on-device

### Data Management
- **Local Storage**: SQLite database
- **State Management**: Riverpod
- **Data Sync**: Can connect to FastAPI backend (optional)

## 🧪 Testing

1. **Run tests:**
   ```bash
   flutter test
   ```

2. **Check for issues:**
   ```bash
   flutter analyze
   ```

## 📝 TODO

- [ ] Implement add/edit student functionality
- [ ] Add data sync with backend API
- [ ] Implement model download on first launch
- [ ] Add offline mode indicator
- [ ] Create teacher input forms for all student fields
- [ ] Add data export functionality

## 🐛 Troubleshooting

### MediaPipe not working
- Ensure minSdkVersion is 24 or higher
- Verify model file exists at `/data/local/tmp/`
- Check device has sufficient storage (>2GB free)

### Build errors
- Run `flutter clean && flutter pub get`
- Delete `build/` folder and rebuild
- Ensure all generated files are created: `flutter pub run build_runner build`

### Performance issues
- Enable release mode: `flutter run --release`
- Check if Isolate is being used for AI inference
- Reduce chart animation duration

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Guide](https://riverpod.dev/)
- [MediaPipe LLM](https://developers.google.com/mediapipe/solutions/genai/llm_inference)
- [Gemma Models](https://ai.google.dev/gemma)
