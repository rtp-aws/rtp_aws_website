# sed notes


## change a single file
Change the word blog to projects anywhere it occurs in a single file and
write the results to stdout

```
sed -e 's/blog/projects/g' index.html | less
```

Likewise do the same thing but rewrite the modified file.  Note, the `-I` says to do the file edits in-place.  You can also use `-i`.  The difference is that -i treats each file separately as if you were running multiple of sed commands on each file.  The more complete syntax is to specify a file extension after `-i` or `-I` like `-i ''` for all files and `-i 'html'` for just the `*.html` files.

```
sed -I -e 's/blog/projects/g' index.html 
```

```
diff --git a/www-root/index.html b/www-root/index.html
index 5760362..8c981fd 100644
--- a/www-root/index.html
+++ b/www-root/index.html
@@ -18,7 +18,7 @@
         <ul>
             <li><a href="index.html">Home</a></li>
             <li><a href="about.html">About</a></li>
-            <li><a href="blog.html">Blog</a></li>
+            <li><a href="projects.html">Blog</a></li>
             <li><a href="meetings.html">Meetings</a></li>
             <li><a href="privacy.html">Privacy</a></li>
             <li><a href="contact.html">Contact</a></li>
Huo-Yang~/progs/rtp_gcp_website/www-root$ 
```

Notice it did not match on capital *B*

```
sed -I -e 's/[Bb]log/projects/g' index.html 
```

```
Huo-Yang~/progs/rtp_gcp_website/www-root$ git diff index.html
diff --git a/www-root/index.html b/www-root/index.html
index 5760362..6bd3e09 100644
--- a/www-root/index.html
+++ b/www-root/index.html
@@ -18,7 +18,7 @@
         <ul>
             <li><a href="index.html">Home</a></li>
             <li><a href="about.html">About</a></li>
-            <li><a href="blog.html">Blog</a></li>
+            <li><a href="projects.html">projects</a></li>
             <li><a href="meetings.html">Meetings</a></li>
             <li><a href="privacy.html">Privacy</a></li>
             <li><a href="contact.html">Contact</a></li>
Huo-Yang~/progs/rtp_gcp_website/www-root$
```

Change `Blog` or `blog` in all files to `projects'. 

```
sed -I -e 's/[Bb]log/projects/g' *.html
```

Whoops!  Diff shows that its a mistake in that the navbar should remain capitalized.

```
git diff *.html | lesss
```

Revert the changes.

```
git checkout *.html
```
```
sed -I -e 's/Blog/Projects/g' *.html
sed -I -e 's/blog/projects/g' *.html
git diff *
```

Yes, that looks better. Except, it created backup files.  ie. `index.html-e`

```
sed -I '' -e 's/Blog/Projects/g' *.html
sed -I '' -e 's/blog/projects/g' *.html
```

That does as intended.  

# different versions, linux, OSX

omg.  If `sed -I ''` doesn't work just go back to this `sed -i''`.  Use lowercase `i` and don't put a space after option.

