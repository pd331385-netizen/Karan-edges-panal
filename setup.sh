#!/bin/bash
# Karan Edge Panel (web page in an Android app) - project generator
set -e
mkdir -p "."
cat > "settings.gradle.kts" <<'GZEOF'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "KaranEdgePanel"
include(":app")
GZEOF
mkdir -p "."
cat > "build.gradle.kts" <<'GZEOF'
plugins {
    id("com.android.application") version "8.5.2" apply false
    id("org.jetbrains.kotlin.android") version "2.0.20" apply false
}
GZEOF
mkdir -p "."
cat > "gradle.properties" <<'GZEOF'
org.gradle.jvmargs=-Xmx3g -Dfile.encoding=UTF-8
android.useAndroidX=true
kotlin.code.style=official
GZEOF
mkdir -p "app"
cat > "app/build.gradle.kts" <<'GZEOF'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.karan.edgepanel"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.karan.edgepanel"
        minSdk = 26
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
}
GZEOF
mkdir -p "app/src/main"
cat > "app/src/main/AndroidManifest.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@android:style/Theme.DeviceDefault.NoActionBar">

        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
GZEOF
mkdir -p "app/src/main/res/values"
cat > "app/src/main/res/values/strings.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">करण एज पैनल</string>
</resources>
GZEOF
mkdir -p "app/src/main/res/values"
cat > "app/src/main/res/values/colors.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#000000</color>
</resources>
GZEOF
mkdir -p "app/src/main/res/drawable"
cat > "app/src/main/res/drawable/ic_launcher_foreground.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <!-- सफेद गोल रिंग -->
    <path
        android:pathData="M54,26 a28,28 0 1,1 0,56 a28,28 0 1,1 0,-56"
        android:strokeColor="#FFFFFF"
        android:strokeWidth="4"
        android:fillColor="#00000000" />
    <!-- सफेद बिजली (बूस्ट) -->
    <path
        android:pathData="M60,32 L43,57 L53,57 L48,78 L67,50 L56,50 Z"
        android:fillColor="#FFFFFF" />
</vector>
GZEOF
mkdir -p "app/src/main/res/mipmap-anydpi-v26"
cat > "app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
GZEOF
mkdir -p "app/src/main/java/com/karan/edgepanel"
cat > "app/src/main/java/com/karan/edgepanel/MainActivity.kt" <<'GZEOF'
package com.karan.edgepanel

import android.annotation.SuppressLint
import android.app.Activity
import android.graphics.Color
import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient

class MainActivity : Activity() {
    private lateinit var web: WebView

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        web = WebView(this)
        web.setBackgroundColor(Color.parseColor("#101010"))
        web.settings.javaScriptEnabled = true
        web.settings.domStorageEnabled = true
        web.webViewClient = WebViewClient()
        setContentView(web)
        web.loadUrl("file:///android_asset/index.html")
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        if (web.canGoBack()) web.goBack() else super.onBackPressed()
    }
}
GZEOF
mkdir -p "app/src/main/assets"
cat > "app/src/main/assets/index.html" <<'GZEOF'
<!doctype html>
<html lang="hi">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>KARAN Gaming Edge Panel</title>
<style>
:root{--accent:#ff3030;--alpha:.94;--width:280px}
*{box-sizing:border-box}body{margin:0;min-height:100vh;background:#101010;color:#f5f5f5;font:16px system-ui}
header{padding:20px 16px 8px;font-size:21px;font-weight:800}.sub{padding:0 16px 16px;color:#aaa;font-size:13px}
#handle{position:fixed;z-index:5;top:42%;right:0;width:22px;height:104px;border:0;border-radius:14px 0 0 14px;background:var(--accent);box-shadow:0 0 18px #ff303077;touch-action:none}
#handle.left{right:auto;left:0;border-radius:0 14px 14px 0}
#panel{position:fixed;z-index:4;top:50%;right:0;transform:translate(105%,-50%);width:min(var(--width),88vw);max-height:82vh;overflow:auto;padding:18px;border:1px solid #ffffff24;border-radius:20px 0 0 20px;background:rgba(28,28,28,var(--alpha));backdrop-filter:blur(18px);box-shadow:0 12px 40px #0009;transition:transform .22s}
#panel.left{right:auto;left:0;border-radius:0 20px 20px 0;transform:translate(-105%,-50%)}
#panel.open{transform:translate(0,-50%)}
.row{display:flex;align-items:center;justify-content:space-between;gap:12px;margin:14px 0}
button,select{color:white;background:#303030;border:1px solid #555;border-radius:10px;padding:10px 12px}
.primary{background:var(--accent);border-color:var(--accent)}h2{margin:0;font-size:19px}
label{font-size:14px;color:#ddd}input[type=range]{width:100%;accent-color:var(--accent)}input[type=color]{width:42px;height:34px;border:0;background:none}
.card{background:#242424;border-radius:14px;padding:13px;margin:10px 0}.value{color:#ff7777;font-weight:700}.small{color:#aaa;font-size:12px;line-height:1.5}
</style></head>
<body>
<header>🎮 KARAN GAMING EDGE PANEL</header><div class="sub">Samsung Edge Panel जैसी कस्टमाइज़ेबल साइड-पट्टी</div>
<button id="handle" aria-label="Open side panel"></button>
<section id="panel">
 <div class="row"><h2>Gaming Panel</h2><button id="close">✕</button></div>
 <div class="card"><strong>Quick Tools</strong>
  <div class="row"><button class="primary" id="timer">गेमिंग टाइमर शुरू</button><button id="info">डिवाइस जानकारी</button></div>
  <div id="toolStatus" class="small">टूल चुनें।</div></div>
 <div class="card"><strong>पट्टी की सेटिंग</strong>
  <div class="row"><label>जगह</label><select id="side"><option value="right">दाईं तरफ</option><option value="left">बाईं तरफ</option></select></div>
  <div class="row"><label>पट्टी की जगह लॉक करें</label><input id="lock" type="checkbox"></div>
  <div class="row"><label>रंग</label><input id="color" type="color" value="#ff3030"></div>
  <label>पारदर्शिता <span id="av" class="value">94%</span></label><input id="alpha" type="range" min="35" max="100" value="94">
  <label>पैनल का आकार <span id="sv" class="value">280 px</span></label><input id="size" type="range" min="220" max="340" value="280">
  <label>ऊपर-नीचे जगह <span id="yv" class="value">42%</span></label><input id="y" type="range" min="8" max="88" value="42">
 </div>
 <div class="card"><strong>डिवाइस स्थिति</strong>
  <div class="row"><span>नेटवर्क</span><span id="online" class="value"></span></div>
  <div class="row"><span>स्क्रीन आकार</span><span id="screen" class="value"></span></div>
  <p class="small">वेब पेज Android की निजी RAM, CPU तापमान या दूसरे ऐप की कैश को भरोसेमंद तरीके से नहीं पढ़ सकता। इनके लिए native Android ऐप और उचित अनुमति चाहिए।</p>
 </div><div id="status" class="small"></div>
</section>
<script>
const $=id=>document.getElementById(id),handle=$('handle'),panel=$('panel');
function side(v){let l=v==='left';handle.classList.toggle('left',l);panel.classList.toggle('left',l);panel.style.left=l?'0':'auto';panel.style.right=l?'auto':'0'}
handle.onclick=()=>panel.classList.add('open');$('close').onclick=()=>panel.classList.remove('open');
$('side').onchange=e=>side(e.target.value);
$('lock').onchange=e=>{const l=e.target.checked;$('side').disabled=l;$('y').disabled=l;$('status').textContent=l?'पट्टी की जगह लॉक है।':'लॉक हटाया गया।'};
$('color').oninput=e=>document.documentElement.style.setProperty('--accent',e.target.value);
$('alpha').oninput=e=>{let v=+e.target.value;document.documentElement.style.setProperty('--alpha',v/100);$('av').textContent=v+'%'};
$('size').oninput=e=>{let v=+e.target.value;document.documentElement.style.setProperty('--width',v+'px');$('sv').textContent=v+' px'};
$('y').oninput=e=>{let v=+e.target.value;handle.style.top=v+'%';$('yv').textContent=v+'%'};
let sx=null;handle.addEventListener('touchstart',e=>{sx=e.touches[0].clientX},{passive:true});handle.addEventListener('touchend',e=>{if(sx===null)return;const dx=e.changedTouches[0].clientX-sx,left=handle.classList.contains('left');if((!left&&dx<-20)||(left&&dx>20))panel.classList.add('open');sx=null});
let start=0,interval=null;
$('timer').onclick=()=>{if(!start){start=Date.now();$('timer').textContent='टाइमर रोकें';interval=setInterval(()=>{let s=Math.floor((Date.now()-start)/1000);$('toolStatus').textContent=`गेमिंग समय: ${Math.floor(s/60)} मिनट ${s%60} सेकंड`},1000)}else{clearInterval(interval);interval=null;start=0;$('timer').textContent='गेमिंग टाइमर शुरू';$('toolStatus').textContent='टाइमर रोक दिया गया।'}};
$('info').onclick=()=>{$('toolStatus').textContent=`स्क्रीन ${screen.width} × ${screen.height}px | ${navigator.onLine?'ऑनलाइन':'ऑफलाइन'}`};
function net(){$('online').textContent=navigator.onLine?'कनेक्टेड':'ऑफलाइन'}
net();$('screen').textContent=`${screen.width} × ${screen.height}`;addEventListener('online',net);addEventListener('offline',net);
</script></body></html>
GZEOF
