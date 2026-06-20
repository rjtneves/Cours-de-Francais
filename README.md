# Cours de Français — multi-user

A single-file French study app (grammar, spaced-repetition vocab, conjugation, daily atelier)
with per-person logins so you, your wife, your sister and your brother-in-law each get your
own progress and streak. No build step, no framework, no monthly cost.

- **Front-end:** `index.html` (everything is in here, including all lesson/verb/atelier content)
- **Backend:** Supabase (login + one progress row per user)
- **Hosting:** GitHub Pages (free)

Until you paste your Supabase keys, the app runs in single-user "local mode" so you can
open `index.html` and use it immediately.

---

## One-time setup (~15 min, all clicking)

### 1. Supabase
1. Create a project at supabase.com (free tier is fine).
2. Left menu → **SQL Editor** → New query → paste the contents of `schema.sql` → **Run**.
3. Left menu → **Authentication → Providers → Email**: keep it enabled. To let family sign in
   instantly without confirming an email, turn **"Confirm email" OFF** (Authentication → Sign In / Providers → Email). Optional but simplest.
4. Left menu → **Project Settings → API**. Copy two values:
   - **Project URL**
   - **anon public** key

### 2. Put the keys in the app
Open `index.html`, find this block near the top, and paste your two values:

```js
window.SUPA_URL = "YOUR_SUPABASE_URL";
window.SUPA_KEY = "YOUR_SUPABASE_ANON_KEY";
```

(The anon key is *designed* to be public — Row-Level Security in `schema.sql` is what keeps
each person's data private. Safe to commit.)

### 3. Push to GitHub + turn on Pages
```bash
# from this folder, after creating an empty repo on github.com:
git remote add origin https://github.com/<you>/cours-de-francais.git
git branch -M main
git push -u origin main
```
Then on GitHub: **Settings → Pages → Build from branch → main / root → Save.**
Your app is live at `https://<you>.github.io/cours-de-francais/` in a minute or two.

### 4. Everyone signs up
Send them the link. Each person clicks **Create account** with their own email + password.
Each gets their own progress and streak. Done.

---

## Adding more content later
All content lives in `index.html` as plain arrays — edit, commit, push, Pages redeploys:
- **Grammar lessons:** the `LESSONS` array
- **Vocabulary:** the `DECK` array
- **Verbs:** the `VERBS` array (the engine auto-builds all 5 tenses)
- **Atelier sets:** the `LOCAL_ATELIER` array

Ask Claude in chat to generate the next batch in the exact array format and paste it in.

## Notes
- "reset my progress" only wipes the signed-in user's row.
- The optional **Générer avec l'IA** button needs a separate API setup and is off by default;
  the free daily atelier works without it.
