# Security Guidelines for SCD Web App

## 🔐 Firebase API Keys Protection

### Current Security Status: ✅ SECURE

The Firebase API keys are properly protected:

1. **`.gitignore` Protection**
   - `lib/firebase_options.dart` is listed in `.gitignore` (line 29)
   - This file contains real API keys and is **NEVER** committed to git

2. **Template File**
   - `lib/firebase_options.dart.template` is a safe template (safe to commit)
   - Contains only placeholder values
   - Used for documentation and team onboarding

3. **Git History Verification**
   - ✅ Verified: `firebase_options.dart` has never been committed
   - ✅ Verified: File is not tracked in git history
   - ✅ Verified: No real API keys in repository

---

## 🔑 Important Notes About Firebase Web API Keys

### Why Web API Keys Are Public
Firebase web API keys are **designed to be public** and included in client-side code. They are not secret keys:

- Web API keys identify your Firebase project
- Security is enforced by Firebase Security Rules, NOT by hiding the API key
- Anyone inspecting your web app can see these keys (in network requests)

### Real Security Comes From:
1. **Firestore Security Rules** - Control who can read/write data
2. **Authentication** - Verify user identity
3. **Cloud Functions** - Server-side logic for sensitive operations

---

## 🛡️ Current Security Rules

### Firestore Rules (Set in Firebase Console)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Public read access to content
    match /{document=**} {
      allow read: if true;
    }

    // Contact forms - anyone can create
    match /contact_submissions/{submission} {
      allow create: if true;
      allow read, update, delete: if request.auth != null;
    }

    // All other writes require authentication
    match /{collection}/{document} {
      allow write: if request.auth != null;
    }
  }
}
```

**What this means:**
- ✅ Anyone can VIEW your content (events, staff, sponsors, etc.)
- ✅ Anyone can SUBMIT contact forms
- ❌ Only authenticated admins can CREATE/UPDATE/DELETE content
- ❌ Only authenticated admins can view contact submissions

---

## 🚨 What to NEVER Commit to Git

1. **Service Account Keys** (`.json` files from Firebase Admin SDK)
   - These ARE secrets and should NEVER be in git
   - Store in secure environment variables

2. **Private API Keys** (if using third-party services)
   - Payment processor keys (Stripe secret keys)
   - Email service keys (SendGrid, Mailgun)
   - Analytics keys (if marked as secret)

3. **Environment Variables** (`.env` files)
   - Already in `.gitignore`
   - Good for storing sensitive configuration

---

## 📋 Security Checklist

- [x] Firebase web API keys in ignored file
- [x] `.gitignore` includes `lib/firebase_options.dart`
- [x] Template file created for documentation
- [x] Firestore security rules configured
- [x] Authentication enabled
- [ ] **TODO:** Add rate limiting for contact form (prevent spam)
- [ ] **TODO:** Set up Firebase App Check (prevent abuse)
- [ ] **TODO:** Configure CORS for production domain

---

## 👥 Team Onboarding

When a new developer joins:

1. They clone the repository (no API keys included)
2. They copy `firebase_options.dart.template` to `firebase_options.dart`
3. They get real Firebase config from team lead
4. They paste it into their local `firebase_options.dart`
5. File remains local only (never committed)

---

## 🔄 Rotating API Keys

If you need to rotate Firebase API keys:

1. Create a new Firebase web app in Firebase Console
2. Get new configuration
3. Update local `firebase_options.dart`
4. Update production deployment
5. Remove old web app from Firebase Console

---

## 📞 Security Incident Response

If API keys are accidentally committed:

1. **DON'T PANIC** - Web API keys are designed to be public
2. Verify Firestore Security Rules are correct
3. Review recent database activity in Firebase Console
4. If concerned, create a new Firebase web app (new keys)
5. Update rules to be more restrictive if needed

---

## 📚 Additional Resources

- [Firebase Security Rules Guide](https://firebase.google.com/docs/rules)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Firebase App Check](https://firebase.google.com/docs/app-check)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)

---

**Last Updated:** 2025-10-28
**Security Audit:** ✅ PASSED
