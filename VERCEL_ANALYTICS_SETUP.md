# Vercel Web Analytics Setup Guide

This guide will help you enable Vercel Web Analytics on your Hexo blog.

## Prerequisites

- A Vercel account (sign up at https://vercel.com/signup if you don't have one)
- Your Hexo blog deployed to Vercel

## Step 1: Enable Web Analytics in Vercel Dashboard

1. Go to your [Vercel dashboard](https://vercel.com/dashboard)
2. Select your project (LimingBlog)
3. Click the **Analytics** tab
4. Click **Enable** from the dialog

> **Note:** Enabling Web Analytics will add new routes (scoped at `/_vercel/insights/*`) after your next deployment.

## Step 2: Enable Analytics in Your Blog Configuration

Open `_config.yml` in the root of your project and find the Vercel Web Analytics section (around line 166). Uncomment the configuration to enable it:

```yaml
## Vercel Web Analytics
## Docs: https://vercel.com/docs/analytics
## To enable: Set enabled to true after deploying to Vercel and enabling analytics in dashboard
analytics:
  vercel:
    enabled: true
```

## Step 3: Deploy Your Changes

Deploy your updated configuration to Vercel:

```bash
git add _config.yml
git commit -m "Enable Vercel Web Analytics"
git push
```

Or use the provided deployment script:

```bash
./push_to_github_and_Vercel.sh
```

## Step 4: Verify Analytics is Working

After deployment:

1. Visit your website
2. Open your browser's Developer Tools (F12)
3. Go to the **Network** tab
4. Refresh the page
5. Look for a request to `/_vercel/insights/script.js` and `/_vercel/insights/view`

If you see these requests, analytics is working correctly!

## Step 5: View Your Data

After a few hours of visitor activity:

1. Go to your [Vercel dashboard](https://vercel.com/dashboard)
2. Select your project
3. Click the **Analytics** tab
4. Explore your visitor data, page views, and more

## Features

Vercel Web Analytics provides:
- **Privacy-focused**: No cookies, GDPR compliant
- **Accurate visitor tracking**: Real user metrics
- **Page view analytics**: See which pages are most popular
- **Geographic data**: Where your visitors come from
- **Referrer tracking**: How visitors find your site
- **Device and browser stats**: What your visitors are using

## Troubleshooting

### Analytics not showing data

- Make sure you've enabled analytics in the Vercel dashboard
- Wait at least a few hours after enabling for data to appear
- Verify the configuration is uncommented in `_config.yml`
- Check the Network tab in your browser to confirm the script is loading

### Script not loading

- Ensure your site is deployed to Vercel (analytics only works on Vercel hosting)
- Clear your browser cache and try again
- Check that `enabled: true` is set in your config

## Additional Resources

- [Vercel Analytics Documentation](https://vercel.com/docs/analytics)
- [Privacy Policy](https://vercel.com/docs/analytics/privacy-policy)
- [Limits and Pricing](https://vercel.com/docs/analytics/limits-and-pricing)

## Implementation Details

The analytics implementation is based on Hexo's theme system:

- **Template file**: `themes/aircloud/layout/_partial/analytics.ejs`
- **Configuration**: `_config.yml`
- **Script type**: HTML implementation (no npm package needed for static sites)

The implementation uses the standard Vercel Web Analytics HTML script, which is perfect for static sites like Hexo blogs.
