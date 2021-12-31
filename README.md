# rtp_aws_website

# originally used aws amplify
I did not take notes.  Retry this agian later.

I thought it would create an s3 bucket behind the scenes but it did not.

As a result, since I am trying to use a s3 based guide and not an aws amplify guide, I just deleted what was
there and restarted below.


# S3 hosted method

## Create bucket

* create bucket name rtp-aws.org


* use region us-east-1 


* use the default acls


* disable the block all public access checkboxes.


* click create bucket.


* select the bucket to edit.


* click properties. select static website hosting.


* specify index.html as homepage.


* click save changes.


* Click permissions

remove all block public access if not done by now


* Edit policy

* Using this guide, https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html

* grab the sample policy and edit bucket name to be `rtp-aws.org/*`

## Route 53 and register.com

* click services->Route 53

* click dns managment->create hosted zone

* enter domain name `rtp-aws.org`

* click `public hosted zone`

* for each of the four dns servers, add them as custom domains in register.com
as custom name servers. NOTE: omit the final dot for the name.

I did this setup twice.  After the second time it still did not work.
The second time, the name servers were not the same.  In register.com
I have the following name server entries for Nameservers (DNS).

```
NS-517.AWSDNS-00.NET
NS-486.AWSDNS-60.COM
NS-1931.AWSDNS-49.CO.UK
NS-1481.AWSDNS-57.ORG
```
In Route 53, I have the following name servers
```
ns-517.awsdns-00.net.
ns-486.awsdns-60.com.
ns-1931.awsdns-49.co.uk.
ns-1481.awsdns-57.org.
```
Using nslookup, I don't get a valid response.

```
Huo-Yang~/progs/rtp_aws_website$ nslookup rtp-aws.org
Server:		192.168.0.1
Address:	192.168.0.1#53

Non-authoritative answer:
*** Can't find rtp-aws.org: No answer
```

Specifying the first aws dns server as the dns server in nslookup gives

```
Huo-Yang~/progs/rtp_aws_website$ nslookup rtp-aws.org NS-517.AWSDNS-00.NET
Server:		NS-517.AWSDNS-00.NET
Address:	205.251.194.5#53

*** Can't find rtp-aws.org: No answer
```

Sometime later when its still not working
```
$ nslookup -type=NS rtp-aws.org
Server:		192.168.86.1
Address:	192.168.86.1#53

Non-authoritative answer:
rtp-aws.org	nameserver = ns-1481.awsdns-57.org.
rtp-aws.org	nameserver = ns-1931.awsdns-49.co.uk.
rtp-aws.org	nameserver = ns-486.awsdns-60.com.
rtp-aws.org	nameserver = ns-517.awsdns-00.net.

Authoritative answers can be found from:

```

The fix was to add an A record in route53.  Afterwards, using
the route53 DNS, it worked.

![img]<imgs/a-record-fix.png>



## CloudFront

Go to cloudfront for the content delivery network. 

Click distribution

First thing, skip everything for now and scroll down to "Request Certificate".  Click that and open in a new tab.

* click request public certificate.

* for domain name add `*.rtp-aws.org`

* add another name add `rtp-aws.org`

* select validation method.  Choose DNS validation.

* click request

At this point you need to wait for them to complete validation.  The 
`apex domain name` rtp-aws.org will validate rather quickly.  The
`*.rtp-aws.org` domain will require an email from register.com
to be confirmed.

* select the either of the domains and in the following page, click 
`create record in Route 53`

* switch to route 53 and a new entry for CNAME will appear.

## switch back to route 53

Eventually you will get an email from register.com for the first domain. 
When that is complete, the steps here can be started.

Hmm. Perhaps since I confirmed the email on the first attempt at this 
I never got a confirm email.  The `*.rtp-aws.org` certificate was validated
on its own.

In route 53, select the `rtp-aws.org` zone we created earlier.

Verify CNAME record is there.  After both domains/zones? are verified, 
still only one CNAME record is there.

## switch back to cloud front

In first edit box for `origin domain` select rtp-aws.org.s3.us-east-1.amazonaws.com`

Origin Name will auto populate.  Leave blank the origin path edit box.

In `Default cache behavior->Viewer` select the radio button for `Redirect HTTP to HTTPS`



* In `Settings` at bottom, for the `Alternate domain names (CNAME)` add items for `www.rtp-aws.org` and `rtp-aws.org`



* In `Settings` at bottom, for the `Custom SSL certificate` use the pull down to select the `*.rtp-aws.org (some letters)` for the cert.

* In `Settings` at bottom, for the `Default root object` add `index.html`

* click `create distribution`






