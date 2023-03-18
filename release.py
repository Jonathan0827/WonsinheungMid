import sys
f = open('Wonsinheung.json', 'w')
f.write('''
{
    "META": {
        "repoName": "원신흥중학교",
        "repoIcon": "https://jonathan.kro.kr/WonsinheungMid/icon.png"
    },
    "App": [{
        "name": "WonsinheungMid",
        "version": "'''+sys.argv[1]+'''",
        "icon": "https://jonathan.kro.kr/WonsinheungMid/icon.png",
        "down": "https://jonathan.kro.kr/WonsinheungMid/build/WonsinheungMid.ipa",
        "description": "Unofficial app for Wonsinheung Middle School.",
        "bundleID": "com.jonathan.WonsinheungMid",
        "category": "Education",
        "changelog": "'''+"- "+sys.argv[2]+'''"
    }]
}
''')
