# AI Integration Setup Guide

This app now uses Google's Gemini AI for real-time tarot reading responses. Follow these steps to set up the AI functionality:

## 1. Get Your Gemini API Key

1. Visit [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy your API key (it will look like: `AIzaSy...`)

## 2. Configure the API Key

1. Open the `.env` file in the root directory of this project
2. Replace `YOUR_API_KEY_HERE` with your actual API key:

```
# Google Gemini AI API Key
GEMINI_API_KEY=AIzaSyYourActualApiKeyHere
```

## 3. Run the App

```bash
flutter pub get
flutter run
```

## 4. Features

- **Real AI Responses**: The chat now connects to Google's Gemini AI for authentic tarot readings
- **Mystical Persona**: The AI responds as "Madame Zora," a wise tarot reader
- **Graceful Fallbacks**: If the API is unavailable, the app provides themed fallback responses
- **Error Handling**: Network issues and API errors are handled gracefully

## 5. Security Notes

- The `.env` file is included in `.gitignore` to protect your API key
- Never commit your actual API key to version control
- The API key is loaded securely at app startup

## 6. Troubleshooting

### API Key Issues
If you see errors like "GEMINI_API_KEY not found," ensure:
1. Your `.env` file exists in the project root
2. The API key is correctly entered
3. The file is named exactly `.env` (not `.env.txt` or similar)

### Network Issues
If responses are slow or fail:
1. Check your internet connection
2. Verify your API key is valid and active
3. Check Google AI API status

### App Crashes
The app includes comprehensive error handling and should not crash due to API issues. If problems persist:
1. Run `flutter clean` and `flutter pub get`
2. Restart the app
3. Check the console for detailed error messages

## 7. AI Persona Details

The AI is configured to respond as "Madame Zora" with:
- Mystical and wise tone
- Tarot-inspired guidance
- Use of mystical symbols (✨, 🔮, 🌙, ⭐)
- Encouraging and empowering responses
- No references to being an AI

Enjoy your mystical tarot readings with real AI! 🔮✨