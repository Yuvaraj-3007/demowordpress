#!/bin/bash
# EV Car Demo - Complete WordPress Setup Script
# Run this inside the WordPress container via Coolify Terminal

echo "========================================="
echo "  EV Car Demo - Setting up content..."
echo "========================================="

# Install WP-CLI
echo "[1/12] Installing WP-CLI..."
curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install Astra Theme
echo "[2/12] Installing Astra theme..."
wp theme install astra --activate --allow-root

# Configure site settings
echo "[3/12] Configuring site settings..."
wp option update blogname "EV Car Demo" --allow-root
wp option update blogdescription "Drive the Future. Drive Electric." --allow-root
wp rewrite structure "/%postname%/" --allow-root
wp rewrite flush --allow-root
wp option update timezone_string "Asia/Kolkata" --allow-root
wp option update posts_per_page 6 --allow-root

# Delete default content
echo "[4/12] Cleaning default content..."
wp post delete 1 --force --allow-root 2>/dev/null
wp post delete 2 --force --allow-root 2>/dev/null

# Create Pages
echo "[5/12] Creating pages..."

HOME_ID=$(wp post create --post_type=page --post_title="Home" --post_status=publish --porcelain --allow-root --post_content='<div style="background:linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),url(/wp-content/uploads/2026/02/ev-hero.jpg) center/cover;padding:120px 20px;text-align:center;margin:0 -20px">
<h1 style="color:#fff;font-size:48px;font-weight:800;margin:0 0 15px">Drive the Future. Drive Electric.</h1>
<p style="color:#e0e0e0;font-size:20px;margin:0 0 30px">India&#39;s most trusted source for electric vehicle reviews, comparisons, and buying guides.</p>
<a href="/?page_id=BLOG_ID" style="background:#00d084;color:#fff;padding:14px 30px;border-radius:30px;text-decoration:none;font-size:18px;font-weight:600;margin:0 8px">Explore EVs</a>
<a href="/?page_id=ABOUT_ID" style="border:2px solid #fff;color:#fff;padding:12px 30px;border-radius:30px;text-decoration:none;font-size:18px;margin:0 8px">About Us</a>
</div>
<div style="height:50px"></div>
<h2 style="text-align:center;font-size:34px;font-weight:700">Why Go Electric?</h2>
<p style="text-align:center;color:#666;font-size:17px">The future of mobility is here. Here&#39;s why millions are making the switch.</p>
<div style="height:15px"></div>
<div style="display:flex;gap:18px;flex-wrap:wrap;justify-content:center;padding:0 20px">
<div style="flex:1;min-width:200px;background:#f0f0f0;border-radius:12px;padding:28px;text-align:center">
<h3 style="font-size:38px;margin:0;color:#00d084">80%</h3>
<p style="font-weight:600;margin:8px 0 5px">Lower Fuel Cost</p>
<p style="color:#555;font-size:13px">Save up to 80% on fuel vs petrol and diesel vehicles.</p>
</div>
<div style="flex:1;min-width:200px;background:#f0f0f0;border-radius:12px;padding:28px;text-align:center">
<h3 style="font-size:38px;margin:0;color:#00d084">0</h3>
<p style="font-weight:600;margin:8px 0 5px">Emissions</p>
<p style="color:#555;font-size:13px">Zero tailpipe emissions. Drive guilt-free.</p>
</div>
<div style="flex:1;min-width:200px;background:#f0f0f0;border-radius:12px;padding:28px;text-align:center">
<h3 style="font-size:38px;margin:0;color:#00d084">1.5L</h3>
<p style="font-weight:600;margin:8px 0 5px">Govt Subsidy</p>
<p style="color:#555;font-size:13px">FAME II subsidies up to Rs 1.5 Lakh on EVs.</p>
</div>
<div style="flex:1;min-width:200px;background:#f0f0f0;border-radius:12px;padding:28px;text-align:center">
<h3 style="font-size:38px;margin:0;color:#00d084">500+</h3>
<p style="font-weight:600;margin:8px 0 5px">Km Range</p>
<p style="color:#555;font-size:13px">Modern EVs offer 500+ km on a single charge.</p>
</div>
</div>
<div style="height:50px"></div>
<div style="background:#1a1a1a;padding:50px 20px;text-align:center;margin:0 -20px">
<h2 style="color:#fff;font-size:30px;margin:0 0 12px">Ready to Make the Switch?</h2>
<p style="color:#ccc;font-size:17px;margin:0 0 22px">Get expert advice and find the perfect EV for your needs.</p>
<a href="/?page_id=CONTACT_ID" style="background:#00d084;color:#fff;padding:14px 30px;border-radius:30px;text-decoration:none;font-size:17px;font-weight:600">Contact Us Today</a>
</div>')

ABOUT_ID=$(wp post create --post_type=page --post_title="About Us" --post_status=publish --porcelain --allow-root --post_content='<div style="background:linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6));padding:80px 20px;text-align:center;margin:0 -20px">
<h1 style="color:#fff;font-size:44px;font-weight:700">About EV Car Demo</h1>
<p style="color:#ddd;font-size:19px">Accelerating India&#39;s transition to electric mobility since 2026</p>
</div>
<div style="height:40px"></div>
<div style="max-width:800px;margin:0 auto;text-align:center">
<h2 style="font-size:28px">Our Mission</h2>
<p style="font-size:17px;color:#444;line-height:1.8">We believe electric vehicles are not just the future - they are the present. Our mission is to empower every Indian with the knowledge they need to make an informed switch to electric mobility.</p>
</div>
<div style="height:30px"></div>
<div style="display:flex;gap:25px;flex-wrap:wrap;justify-content:center;padding:0 20px">
<div style="flex:1;min-width:220px;max-width:300px;text-align:center;padding:25px;background:#f8f9fa;border-radius:12px">
<h3 style="font-size:42px;color:#00d084;margin:0">500+</h3>
<p style="font-weight:600;font-size:17px">Reviews Published</p>
</div>
<div style="flex:1;min-width:220px;max-width:300px;text-align:center;padding:25px;background:#f8f9fa;border-radius:12px">
<h3 style="font-size:42px;color:#00d084;margin:0">2M+</h3>
<p style="font-weight:600;font-size:17px">Monthly Readers</p>
</div>
<div style="flex:1;min-width:220px;max-width:300px;text-align:center;padding:25px;background:#f8f9fa;border-radius:12px">
<h3 style="font-size:42px;color:#00d084;margin:0">50+</h3>
<p style="font-weight:600;font-size:17px">Brand Partners</p>
</div>
</div>
<div style="height:40px"></div>
<h2 style="text-align:center;font-size:28px">Our Team</h2>
<div style="display:flex;gap:25px;flex-wrap:wrap;justify-content:center;padding:0 20px">
<div style="width:200px;text-align:center">
<div style="width:100px;height:100px;border-radius:50%;background:#e0e0e0;margin:0 auto 12px;display:flex;align-items:center;justify-content:center;font-size:32px;color:#888">YP</div>
<h4 style="margin:0 0 3px">Yuvaraj Pandian</h4>
<p style="color:#00d084;font-size:13px;margin:0 0 5px">Founder</p>
</div>
<div style="width:200px;text-align:center">
<div style="width:100px;height:100px;border-radius:50%;background:#e0e0e0;margin:0 auto 12px;display:flex;align-items:center;justify-content:center;font-size:32px;color:#888">RK</div>
<h4 style="margin:0 0 3px">Ramesh Kumar</h4>
<p style="color:#00d084;font-size:13px;margin:0 0 5px">Senior Reviewer</p>
</div>
<div style="width:200px;text-align:center">
<div style="width:100px;height:100px;border-radius:50%;background:#e0e0e0;margin:0 auto 12px;display:flex;align-items:center;justify-content:center;font-size:32px;color:#888">PS</div>
<h4 style="margin:0 0 3px">Priya Sharma</h4>
<p style="color:#00d084;font-size:13px;margin:0 0 5px">Tech Editor</p>
</div>
</div>')

SERVICES_ID=$(wp post create --post_type=page --post_title="Services" --post_status=publish --porcelain --allow-root --post_content='<div style="background:linear-gradient(135deg,#1a1a2e,#16213e);padding:70px 20px;text-align:center;margin:0 -20px">
<h1 style="color:#fff;font-size:44px;font-weight:700">Our Services</h1>
<p style="color:#ccc;font-size:19px">Comprehensive EV solutions for buyers, dealers, and manufacturers</p>
</div>
<div style="height:40px"></div>
<h2 style="text-align:center;font-size:28px">What We Offer</h2>
<div style="height:20px"></div>
<div style="display:flex;gap:20px;flex-wrap:wrap;justify-content:center;padding:0 20px">
<div style="flex:1;min-width:260px;max-width:320px;border:1px solid #e8e8e8;border-radius:12px;padding:30px;text-align:center">
<h3 style="font-size:19px">EV Reviews</h3>
<p style="color:#555;font-size:14px">Comprehensive hands-on reviews with real-world testing of range, performance, and value.</p>
</div>
<div style="flex:1;min-width:260px;max-width:320px;border:1px solid #e8e8e8;border-radius:12px;padding:30px;text-align:center">
<h3 style="font-size:19px">Charging Solutions</h3>
<p style="color:#555;font-size:14px">Home charger installation guidance, public charging maps, and cost calculators.</p>
</div>
<div style="flex:1;min-width:260px;max-width:320px;border:1px solid #e8e8e8;border-radius:12px;padding:30px;text-align:center">
<h3 style="font-size:19px">Price Comparison</h3>
<p style="color:#555;font-size:14px">Side-by-side comparisons of price, features, range, and total cost of ownership.</p>
</div>
</div>
<div style="height:15px"></div>
<div style="display:flex;gap:20px;flex-wrap:wrap;justify-content:center;padding:0 20px">
<div style="flex:1;min-width:260px;max-width:320px;border:1px solid #e8e8e8;border-radius:12px;padding:30px;text-align:center">
<h3 style="font-size:19px">Subsidy Calculator</h3>
<p style="color:#555;font-size:14px">Find out how much you save with FAME II, state subsidies, and tax benefits.</p>
</div>
<div style="flex:1;min-width:260px;max-width:320px;border:1px solid #e8e8e8;border-radius:12px;padding:30px;text-align:center">
<h3 style="font-size:19px">Buying Guide</h3>
<p style="color:#555;font-size:14px">Step-by-step guides for first-time EV buyers. Battery types, charging, warranty.</p>
</div>
<div style="flex:1;min-width:260px;max-width:320px;border:1px solid #e8e8e8;border-radius:12px;padding:30px;text-align:center">
<h3 style="font-size:19px">Industry News</h3>
<p style="color:#555;font-size:14px">Breaking news on launches, policies, charging updates, and global EV trends.</p>
</div>
</div>')

BLOG_ID=$(wp post create --post_type=page --post_title="Blog" --post_status=publish --post_content="" --porcelain --allow-root)

FAQ_ID=$(wp post create --post_type=page --post_title="FAQ" --post_status=publish --porcelain --allow-root --post_content='<div style="background:linear-gradient(135deg,#0f3443,#34e89e);padding:70px 20px;text-align:center;margin:0 -20px">
<h1 style="color:#fff;font-size:44px;font-weight:700">Frequently Asked Questions</h1>
<p style="color:#e0e0e0;font-size:19px">Everything you need to know about electric vehicles</p>
</div>
<div style="height:40px"></div>
<div style="max-width:800px;margin:0 auto;padding:0 20px">
<h2 style="font-size:22px;color:#00d084">General EV Questions</h2>
<div style="border:1px solid #e8e8e8;border-radius:10px;margin-bottom:12px;padding:18px 22px">
<h3 style="font-size:17px;margin:0 0 8px">How far can an electric car go on a single charge?</h3>
<p style="color:#555;font-size:14px;margin:0">Modern EVs offer 300-500 km range. Premium models go over 700 km. For daily commutes of 40-80 km, charge once or twice a week.</p>
</div>
<div style="border:1px solid #e8e8e8;border-radius:10px;margin-bottom:12px;padding:18px 22px">
<h3 style="font-size:17px;margin:0 0 8px">How long does it take to charge an EV?</h3>
<p style="color:#555;font-size:14px;margin:0">Home charger: 8-12 hours (overnight). Fast charger (50kW): 30-60 min to 80%. Ultra-fast (150kW): under 20 minutes.</p>
</div>
<div style="border:1px solid #e8e8e8;border-radius:10px;margin-bottom:12px;padding:18px 22px">
<h3 style="font-size:17px;margin:0 0 8px">Are electric cars more expensive?</h3>
<p style="color:#555;font-size:14px;margin:0">Higher upfront cost but 5-year total cost is lower. Save 80% on fuel, cheaper maintenance, and govt subsidies up to Rs 1.5 Lakh.</p>
</div>
<h2 style="font-size:22px;color:#00d084;margin-top:25px">Charging and Infrastructure</h2>
<div style="border:1px solid #e8e8e8;border-radius:10px;margin-bottom:12px;padding:18px 22px">
<h3 style="font-size:17px;margin:0 0 8px">Can I charge an EV at home?</h3>
<p style="color:#555;font-size:14px;margin:0">Yes! Use a standard 15A socket for slow charging or install a wall box for faster charging. Installation costs Rs 5,000-30,000.</p>
</div>
<div style="border:1px solid #e8e8e8;border-radius:10px;margin-bottom:12px;padding:18px 22px">
<h3 style="font-size:17px;margin:0 0 8px">How much does it cost to charge?</h3>
<p style="color:#555;font-size:14px;margin:0">About Rs 1 per km vs Rs 5-7 per km for petrol. A full charge costs Rs 250-300 for 300+ km range.</p>
</div>
</div>')

CONTACT_ID=$(wp post create --post_type=page --post_title="Contact" --post_status=publish --porcelain --allow-root --post_content='<div style="background:linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6));padding:70px 20px;text-align:center;margin:0 -20px">
<h1 style="color:#fff;font-size:44px;font-weight:700">Contact Us</h1>
<p style="color:#ddd;font-size:19px">We&#39;d love to hear from you</p>
</div>
<div style="height:40px"></div>
<div style="display:flex;gap:30px;flex-wrap:wrap;padding:0 20px;max-width:900px;margin:0 auto">
<div style="flex:1;min-width:280px">
<h2 style="font-size:26px">Get in Touch</h2>
<p style="color:#555;font-size:15px;line-height:1.7">Whether you have a question about EVs, want to partner with us, or need buying advice - our team is here to help.</p>
<div style="margin:25px 0">
<div style="margin-bottom:20px">
<h4 style="margin:0 0 5px;font-size:15px">Email</h4>
<p style="margin:0;color:#555">info@evcar-demo.com</p>
</div>
<div style="margin-bottom:20px">
<h4 style="margin:0 0 5px;font-size:15px">Phone</h4>
<p style="margin:0;color:#555">+91 98765 43210</p>
</div>
<div style="margin-bottom:20px">
<h4 style="margin:0 0 5px;font-size:15px">Location</h4>
<p style="margin:0;color:#555">T. Nagar, Chennai - 600017, Tamil Nadu, India</p>
</div>
</div>
<h3 style="font-size:18px">Follow Us</h3>
<p style="color:#555;font-size:14px">Instagram: @evcar_demo | Twitter: @evcar_demo | YouTube: EV Car Demo</p>
</div>
<div style="flex:1;min-width:280px;background:#f8f9fa;border-radius:12px;padding:30px">
<h3 style="font-size:20px;margin:0 0 18px">Send a Message</h3>
<div style="margin-bottom:12px"><label style="display:block;font-size:13px;font-weight:600;margin-bottom:4px">Name</label><input type="text" placeholder="Your name" style="width:100%;padding:10px 12px;border:1px solid #ddd;border-radius:8px;font-size:14px;box-sizing:border-box" disabled></div>
<div style="margin-bottom:12px"><label style="display:block;font-size:13px;font-weight:600;margin-bottom:4px">Email</label><input type="email" placeholder="your@email.com" style="width:100%;padding:10px 12px;border:1px solid #ddd;border-radius:8px;font-size:14px;box-sizing:border-box" disabled></div>
<div style="margin-bottom:15px"><label style="display:block;font-size:13px;font-weight:600;margin-bottom:4px">Message</label><textarea placeholder="Write your message..." rows="4" style="width:100%;padding:10px 12px;border:1px solid #ddd;border-radius:8px;font-size:14px;box-sizing:border-box;resize:vertical" disabled></textarea></div>
<button style="background:#00d084;color:#fff;border:none;padding:12px 30px;border-radius:8px;font-size:15px;font-weight:600;width:100%" disabled>Send (Demo)</button>
</div>
</div>')

echo "Pages created: Home=$HOME_ID About=$ABOUT_ID Services=$SERVICES_ID Blog=$BLOG_ID FAQ=$FAQ_ID Contact=$CONTACT_ID"

# Set static front page
echo "[6/12] Setting front page..."
wp option update show_on_front "page" --allow-root
wp option update page_on_front $HOME_ID --allow-root
wp option update page_for_posts $BLOG_ID --allow-root

# Create categories
echo "[7/12] Creating categories..."
wp term create category "EV Reviews" --allow-root 2>/dev/null
wp term create category "EV News" --allow-root 2>/dev/null
wp term create category "Buying Guide" --allow-root 2>/dev/null
wp term create category "Comparison" --allow-root 2>/dev/null
wp term create category "Technology" --allow-root 2>/dev/null

# Create blog posts
echo "[8/12] Creating blog articles..."

wp post create --post_title="Tesla Model 3 2026 Review: Still the King of EVs?" --post_status=publish --post_category="EV Reviews" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">The Tesla Model 3 continues to dominate the electric sedan market in 2026. With its refreshed design, improved range of 390 miles, and enhanced autopilot features, it remains a top choice.</p>
<h3>Key Specs</h3>
<table style="width:100%;border-collapse:collapse"><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Range</strong></td><td style="padding:10px;border:1px solid #ddd">390 miles</td></tr><tr><td style="padding:10px;border:1px solid #ddd"><strong>0-60 mph</strong></td><td style="padding:10px;border:1px solid #ddd">3.1 seconds</td></tr><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Price</strong></td><td style="padding:10px;border:1px solid #ddd">Starting at Rs 35 Lakhs</td></tr></table>
<h3>What We Love</h3><ul><li>Minimalist 15.4-inch touchscreen</li><li>Premium vegan leather seats</li><li>Industry-leading autopilot</li><li>Massive Supercharger network</li></ul>
<p><strong>Rating: 9.2/10</strong></p>'

wp post create --post_title="Tata Nexon EV Max: Best Electric SUV in India" --post_status=publish --post_category="EV Reviews" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">The Tata Nexon EV Max has set a new benchmark for electric SUVs in India. 437 km range, fast charging, and 5-star safety at an unbeatable price.</p>
<h3>Key Specs</h3>
<table style="width:100%;border-collapse:collapse"><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Range</strong></td><td style="padding:10px;border:1px solid #ddd">437 km (ARAI)</td></tr><tr><td style="padding:10px;border:1px solid #ddd"><strong>Fast Charging</strong></td><td style="padding:10px;border:1px solid #ddd">0-80% in 56 min</td></tr><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Price</strong></td><td style="padding:10px;border:1px solid #ddd">Starting at Rs 14.74 Lakhs</td></tr></table>
<h3>What We Love</h3><ul><li>Best value-for-money EV in India</li><li>Connected car technology</li><li>5-star Global NCAP safety</li><li>Electric sunroof</li></ul>
<p><strong>Rating: 8.8/10</strong></p>'

wp post create --post_title="Top 5 Electric Cars to Buy in 2026" --post_status=publish --post_category="Buying Guide" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">Looking to buy an EV in 2026? Here are our top 5 picks across budgets:</p>
<h3>1. Tata Nexon EV (Budget Pick) - Rs 14.74L</h3><p>Best value for money EV in India.</p>
<h3>2. MG ZS EV (Mid-Range) - Rs 18.98L</h3><p>Great features and range.</p>
<h3>3. Hyundai Ioniq 5 (Premium) - Rs 44.95L</h3><p>Ultra-fast 800V charging.</p>
<h3>4. Tesla Model 3 (Performance) - Rs 35L</h3><p>Best driving experience.</p>
<h3>5. BYD Seal (New Entry) - Rs 41L</h3><p>Impressive tech and range.</p>'

wp post create --post_title="India to Have 1 Million EV Charging Stations by 2028" --post_status=publish --post_category="EV News" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">The Indian government announced plans to install 1 million EV charging stations across the country by 2028.</p>
<h3>Key Highlights</h3>
<ul><li>Every 25 km on national highways will have a charging point</li><li>All new buildings must include EV charging infrastructure</li><li>Rs 10,000 Crore allocated for charging network</li><li>Fast charging at all major fuel stations</li></ul>
<h3>Timeline</h3>
<table style="width:100%;border-collapse:collapse"><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>2026</strong></td><td style="padding:10px;border:1px solid #ddd">250,000 stations</td></tr><tr><td style="padding:10px;border:1px solid #ddd"><strong>2027</strong></td><td style="padding:10px;border:1px solid #ddd">600,000 stations</td></tr><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>2028</strong></td><td style="padding:10px;border:1px solid #ddd">1,000,000 target</td></tr></table>'

wp post create --post_title="Hyundai Ioniq 5 vs BYD Seal: Which Premium EV?" --post_status=publish --post_category="Comparison" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">Two premium EV contenders go head-to-head. The Ioniq 5 with its retro-futuristic design vs the sporty BYD Seal.</p>
<h3>Comparison</h3>
<table style="width:100%;border-collapse:collapse"><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Feature</strong></td><td style="padding:10px;border:1px solid #ddd"><strong>Ioniq 5</strong></td><td style="padding:10px;border:1px solid #ddd"><strong>BYD Seal</strong></td></tr><tr><td style="padding:10px;border:1px solid #ddd">Price</td><td style="padding:10px;border:1px solid #ddd">Rs 44.95L</td><td style="padding:10px;border:1px solid #ddd">Rs 41L</td></tr><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd">Range</td><td style="padding:10px;border:1px solid #ddd">631 km</td><td style="padding:10px;border:1px solid #ddd">650 km</td></tr><tr><td style="padding:10px;border:1px solid #ddd">0-100</td><td style="padding:10px;border:1px solid #ddd">5.2s</td><td style="padding:10px;border:1px solid #ddd">3.8s</td></tr></table>
<p><strong>Ioniq 5: 8.9/10 | BYD Seal: 8.7/10</strong></p>'

wp post create --post_title="How to Set Up a Home EV Charging Station" --post_status=publish --post_category="Buying Guide" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">Setting up home charging is the first step to EV ownership. Here is everything you need to know.</p>
<h3>Charging Levels</h3>
<div style="display:flex;gap:12px;flex-wrap:wrap;margin:15px 0">
<div style="flex:1;min-width:180px;background:#e8f5e9;padding:18px;border-radius:10px"><h4 style="margin:0 0 6px;color:#2e7d32">Level 1 (Slow)</h4><p style="margin:0;font-size:13px">Standard 15A socket. 8-15 hours.</p></div>
<div style="flex:1;min-width:180px;background:#e3f2fd;padding:18px;border-radius:10px"><h4 style="margin:0 0 6px;color:#1565c0">Level 2 (Fast)</h4><p style="margin:0;font-size:13px">Wall box 7.2kW. 4-6 hours.</p></div>
<div style="flex:1;min-width:180px;background:#fff3e0;padding:18px;border-radius:10px"><h4 style="margin:0 0 6px;color:#e65100">Level 3 (Rapid)</h4><p style="margin:0;font-size:13px">DC fast 25kW+. Not for home use.</p></div>
</div>
<h3>Monthly Cost</h3>
<ul><li>Electricity: ~240 kWh/month = Rs 1,920</li><li>Equivalent petrol cost: Rs 8,000-10,000</li><li><strong>You save Rs 6,000-8,000/month!</strong></li></ul>'

wp post create --post_title="Solid State Batteries Are Here: EV Tech in 2026" --post_status=publish --post_category="Technology" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">2026 marks a turning point. Solid-state batteries are entering mass production, bringing massive improvements.</p>
<h3>Key Benefits</h3>
<div style="display:flex;gap:12px;flex-wrap:wrap;margin:15px 0">
<div style="flex:1;min-width:180px;border-left:4px solid #00d084;padding:12px 18px;background:#f9f9f9"><h4 style="margin:0 0 5px">2x Range</h4><p style="margin:0;color:#555;font-size:13px">500 km becomes 1000 km.</p></div>
<div style="flex:1;min-width:180px;border-left:4px solid #00d084;padding:12px 18px;background:#f9f9f9"><h4 style="margin:0 0 5px">10-Min Charge</h4><p style="margin:0;color:#555;font-size:13px">Faster than filling petrol.</p></div>
<div style="flex:1;min-width:180px;border-left:4px solid #00d084;padding:12px 18px;background:#f9f9f9"><h4 style="margin:0 0 5px">20+ Year Life</h4><p style="margin:0;color:#555;font-size:13px">Much slower degradation.</p></div>
</div>
<h3>Who Is Leading?</h3>
<ul><li><strong>Toyota:</strong> 1,200 km range EV in 2026</li><li><strong>Samsung SDI:</strong> Cells for BMW and Hyundai</li><li><strong>QuantumScape:</strong> Partnered with Volkswagen</li></ul>'

wp post create --post_title="MG Windsor EV Review: Luxury on a Budget" --post_status=publish --post_category="EV Reviews" --allow-root --post_content='<p style="font-size:17px;line-height:1.8">MG brings luxury-car features to a price point that makes petrol buyers reconsider. We spent a week with it.</p>
<h3>Key Specs</h3>
<table style="width:100%;border-collapse:collapse"><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Range</strong></td><td style="padding:10px;border:1px solid #ddd">460 km</td></tr><tr><td style="padding:10px;border:1px solid #ddd"><strong>Fast Charging</strong></td><td style="padding:10px;border:1px solid #ddd">0-80% in 40 min</td></tr><tr style="background:#f0f0f0"><td style="padding:10px;border:1px solid #ddd"><strong>Price</strong></td><td style="padding:10px;border:1px solid #ddd">Rs 13.50 Lakhs</td></tr></table>
<h3>What We Love</h3><ul><li>15.6-inch tilting touchscreen</li><li>Best-in-class rear legroom</li><li>Excellent ride quality</li><li>BaaS brings price to Rs 9.99L</li></ul>
<p><strong>Rating: 8.5/10</strong></p>'

# Create navigation menu
echo "[9/12] Creating navigation menu..."
MENU_ID=$(wp menu create "Main Menu" --porcelain --allow-root)
wp menu item add-post $MENU_ID $HOME_ID --title="Home" --allow-root
wp menu item add-post $MENU_ID $ABOUT_ID --title="About" --allow-root
wp menu item add-post $MENU_ID $SERVICES_ID --title="Services" --allow-root
wp menu item add-post $MENU_ID $BLOG_ID --title="Blog" --allow-root
wp menu item add-post $MENU_ID $FAQ_ID --title="FAQ" --allow-root
wp menu item add-post $MENU_ID $CONTACT_ID --title="Contact" --allow-root
wp menu location assign $MENU_ID primary --allow-root

# Download and add images
echo "[10/12] Downloading images..."
mkdir -p /var/www/html/wp-content/uploads/2026/02
cd /tmp
curl -sL -o ev-hero.jpg 'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=1200&q=80'
curl -sL -o tesla.jpg 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=1200&q=80'
curl -sL -o ev-suv.jpg 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=1200&q=80'
curl -sL -o ev-charging.jpg 'https://images.unsplash.com/photo-1647166545674-ce28ce93bdca?w=1200&q=80'
curl -sL -o ev-lineup.jpg 'https://images.unsplash.com/photo-1571987502227-9231b837d92a?w=1200&q=80'
curl -sL -o ev-about.jpg 'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=1200&q=80'
cp *.jpg /var/www/html/wp-content/uploads/2026/02/
chown -R www-data:www-data /var/www/html/wp-content/uploads/

# Add custom CSS
echo "[11/12] Adding custom styling..."
wp eval '
$css = "
body { font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, sans-serif; }
a { color: #00d084; }
a:hover { color: #00a86b; }
.main-header-bar { box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
.main-navigation a { font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
.ast-separate-container .ast-article-post { border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
@media (max-width: 768px) { h1 { font-size: 28px !important; } }
";
wp_update_custom_css_post($css);
' --allow-root

echo "[12/12] Done!"
echo "========================================="
echo "  EV Car Demo is ready!"
echo "  Pages: Home, About, Services, Blog, FAQ, Contact"
echo "  Articles: 8 published"
echo "  Theme: Astra"
echo "========================================="