# Recruitment Exercise - Grep

## Introduction

For this exercise you need to build your own [grep](https://en.wikipedia.org/wiki/Grep)-like tool; a console application which can search text files for lines matching a regular expression. You don't need to build a fully-fledged grep tool, specifically we need a tool which can;

- Read in one or more input text files, potentially quite large

- Run a supplied regular expression with capture groups against each line in the input

- Output the capture group values in CSV format, where the group names are the column headings


## Objective

Using the GrepTool solution as a starting point, build a Windows console application in C#. The application needs to support the arguments specified below. You're welcome to leverage NuGet packages as you see fit, but do write the core grepping functionality yourself.

### Console Arguments

Example usage

```
> greptool.exe -i *.txt -r "regex" -o Results.csv
```

- `-i {searchPath}`
  The input file path, with support for wildcards to match multiple files.

- `-r {regex}`

  A case insensitive regular expression which is matched against whole lines.

- `-o {outputFile}`

  The output file path. Existing files should get overwritten.


### Test Case

A good data set to develop against is the [Squid Access Log data](http://www.secrepo.com/squid/access.log.gz) from [Security Repo](http://www.secrepo.com/). It's a 22MB compressed / 210MB uncompressed access.log file from a [Squid Proxy](http://www.squid-cache.org/).

It looks like this

```
1157689312.049   5006 10.105.21.199 TCP_MISS/200 19763 CONNECT login.yahoo.com:443 badeyek DIRECT/209.73.177.115 -
1157689320.327   2864 10.105.21.199 TCP_MISS/200 10182 GET http://www.goonernews.com/ badeyek DIRECT/207.58.145.61 text/html
1157689320.343   1357 10.105.21.199 TCP_REFRESH_HIT/304 214 GET http://www.goonernews.com/styles.css badeyek DIRECT/207.58.145.61 -
1157689321.315      1 10.105.21.199 TCP_HIT/200 1464 GET http://www.goonernews.com/styles.css badeyek NONE/- text/css
1157689322.780   1464 10.105.21.199 TCP_HIT/200 5626 GET http://www.google-analytics.com/urchin.js badeyek NONE/- text/javascript
1157689323.718   3856 10.105.21.199 TCP_MISS/200 30169 GET http://www.goonernews.com/ badeyek DIRECT/207.58.145.61 text/html
1157689324.156   1372 10.105.21.199 TCP_MISS/200 399 GET http://www.google-analytics.com/__utm.gif? badeyek DIRECT/66.102.9.147 image/gif
```

The data is in the [Squid Access Log Format](http://wiki.squid-cache.org/Features/LogFormat) and we'd like to use a regex to parse it into CSV format. Instead of extracting everything, let's focus on HTTP error responses (e.g. 4xx, 5xx). Let's use a modified version of [this regex](https://gist.github.com/k4otix/8326824a0f90287bbe407ce8182359f0) to capture the fields for log lines with errors only.

```
\d+\.\d+\s+(?<duration>\d+)\s+(?<src>[^\s]+)\s(?<protocol>TCP|UDP|NONE)_(?<result>[^/]+)/(?<status>40[0-6|8-9]|5\d{2})\s+(?<bytes_in>\d+)\s+(?<http_method>[^\s]+)\s+(?<url>[^\s]+):?(?<dest_port>\d+)?\s+(?<user>[^\s]+)\s+(?<hierarchy_code>[^/]+)/(?<dest>[^\s]+)\s+(?<http_content_type>.*)$
```


Before we start, let's [split the file](http://www.filesplitter.org/) into smaller chunks (e.g. 30MB). We can then use the GrepTool to extract the data. Example command;

```
> SET regex=...
> greptool.exe -i access.log.* -r %regex% -o Errors.csv
```

Example CSV output;

```
duration,src,protocol,result,status,bytes_in,http_method,url,dest_port,user,hierarchy_code,dest,http_content_type
1,10.105.37.180,TCP,DENIED,401,1764,POST,http://www.ceruleanstudios.com/cgi-bin/autosync/autosync,,-,NONE,-,text/html
61292,10.105.33.214,TCP,MISS,500,1392,GET,http://pgq.yahoo.com/feed/pg4?,,adeolaegbedokun,DIRECT,66.163.175.128,text/html
2,10.105.23.141,TCP,DENIED,401,1709,GET,http://switchboard.real.com/player/?,,-,NONE,-,text/html
1,10.105.23.141,TCP,DENIED,401,1713,GET,http://xksduuczeanpqniv.com/lobster.jpg,,-,NONE,-,text/html
```

You're welcome to implement this using an ASP.Net technology of your choice (Web Forms, MVC, Web API, etc.). Pick whichever you think is best.

## Assessment

We'll carry out an automated test on your solution, followed by a manual code review. Please treat this as you would a normal programming task, and adhere to your normal coding standards.


Once you've completed the exercise, please submit the solution files as a .zip file, via your HR point of contact or recruitment agent.

Good luck!
