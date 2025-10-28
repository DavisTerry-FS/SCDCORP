# Firebase Setup Instructions for SCD Web App

## Current Status
❌ Firebase is NOT configured yet - the app uses placeholder API keys
✅ All code is ready and waiting for real Firebase credentials

---

## Step 1: Get Your Firebase Web Configuration

1. Go to https://console.firebase.google.com/
2. Select your **scdwebapp** project
3. Click the **⚙️ Settings** icon → **Project settings**
4. Scroll down to "Your apps"
5. If you don't have a web app yet:
   - Click the **</>** (Web platform) icon
   - Register app with nickname: "SCD Web"
   - Don't need Firebase Hosting for now
6. You'll see configuration code like this:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSy...",  // Copy this value
  authDomain: "scdwebapp.firebaseapp.com",  // Copy this
  projectId: "scdwebapp",  // Should already be correct
  storageBucket: "scdwebapp.appspot.com",  // Copy this
  messagingSenderId: "123456789012",  // Copy this
  appId: "1:123456789012:web:abc123...",  // Copy this
  measurementId: "G-XXXXXXXXXX"  // Copy this
};
```

---

## Step 2: Update firebase_options.dart

Open: `/Users/terrance/Desktop/Repo/SCDCORP/scd_web/lib/firebase_options.dart`

Find the `web` section (around line 66) and replace:
- `YOUR_WEB_API_KEY` → your `apiKey` value
- `YOUR_WEB_APP_ID` → your `appId` value
- `YOUR_MESSAGING_SENDER_ID` → your `messagingSenderId` value
- `your-project-id.firebaseapp.com` → your `authDomain` value
- `your-project-id.appspot.com` → your `storageBucket` value
- `G-XXXXXXXXXX` → your `measurementId` value

---

## Step 3: Enable Firestore Database

1. In Firebase Console, click **Firestore Database** (left menu)
2. Click **Create database**
3. Choose **Start in test mode** (we'll secure it later)
4. Select location: **us-central** (or closest to you)
5. Click **Enable**

---

## Step 4: Enable Authentication (for Admin Login)

1. Click **Authentication** (left menu)
2. Click **Get started**
3. Click **Email/Password** provider
4. Toggle **Enable**
5. Click **Save**
6. Go to **Users** tab
7. Click **Add user**
8. Enter your admin email and password
9. Click **Add user**

---

## Step 5: Set Firestore Security Rules

In Firestore Database → **Rules** tab, replace with:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow public read access to all collections
    match /{document=**} {
      allow read: if true;
    }

    // Only authenticated users can write
    match /contact_submissions/{submission} {
      allow create: if true;  // Anyone can submit contact forms
      allow read, update, delete: if request.auth != null;
    }

    // Admin-only write access for content
    match /{collection}/{document} {
      allow write: if request.auth != null;
    }
  }
}
```

Click **Publish**

---

## Step 6: Seed the Database

Once Firebase is configured:

1. Navigate to: http://localhost:59000/admin/login
2. Login with the email/password you created in Step 4
3. You'll be taken to the Admin Dashboard
4. Click the **"Seed Database"** button
5. This will populate Firestore with sample data:
   - Mission, vision, history
   - 8 staff members
   - 4 events
   - 3 pillars
   - 10 sponsors
   - 6 gallery items

---

## Step 7: Test the App

After seeding, visit these pages to see the data:
- http://localhost:59000/ (Home - should show pillars)
- http://localhost:59000/about (About - should show staff)
- http://localhost:59000/events (Events - should show 4 events)
- http://localhost:59000/media (Media - should show gallery)

---

## Troubleshooting

### Still seeing "No sponsors found"?
- Make sure you clicked "Seed Database" in admin panel
- Check Firestore console - you should see collections with data

### Firestore errors in console?
- Verify your API keys are correct in `firebase_options.dart`
- Make sure Firestore is enabled in Firebase Console
- Check security rules allow public read

### Can't login to admin?
- Verify you created a user in Authentication
- Make sure Email/Password provider is enabled

---

## What You're Seeing Now

Your app at http://localhost:59000 shows:
- ✅ Header with navigation
- ✅ Hero image
- ✅ Three pillar cards (static data)
- ✅ Footer (trying to load sponsors from Firestore → shows "No sponsors found")

Once Firebase is configured and seeded, you'll see ALL content dynamically loaded!
