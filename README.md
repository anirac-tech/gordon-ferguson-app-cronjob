# ⚡ Dart Cronjob

Checks wordpress site for new post by comparing ID with stored ID.
If the post is different, it sends a push notification.


## ⚙️ Configuration

| Setting           | Value           |
| ----------------- | --------------- |
| Runtime           | Dart (^2.17)     |
| Entrypoint        | `lib/main.dart` |
| Build Commands    | `dart pub get`  |
| Permissions       | `any`           |
| Timeout (Seconds) | 15              |

## 🔒 Environment Variables

API_KEY
