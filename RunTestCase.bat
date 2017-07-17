ECHO Before starting, you need to:
ECHO 1. Download and decompress some Squid Access Logs
ECHO    e.g. http://www.secrepo.com/squid/access.log.gz
ECHO 2. Split the file into smaller chunks (for fun..)
ECHO    e.g. http://www.filesplitter.org/
PAUSE
SET regex=\d+\.\d+\s+(?<duration>\d+)\s+(?<src>[^\s]+)\s(?<protocol>TCP|UDP|NONE)_(?<result>[^/]+)/(?<status>40[0-6|8-9]|5\d{2})\s+(?<bytes_in>\d+)\s+(?<http_method>[^\s]+)\s+(?<url>[^\s]+):?(?<dest_port>\d+)?\s+(?<user>[^\s]+)\s+(?<hierarchy_code>[^/]+)/(?<dest>[^\s]+)\s+(?<http_content_type>.*)$
greptool.exe -i access.log.* -r %regex% -o Errors.csv