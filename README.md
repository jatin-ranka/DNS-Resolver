# DNS-Resolver 
A Ruby program which does domain name resolution and prints the lookup chain, until it resolves to an IPv4address.

## Example

  ## Zone 
  ```
#RECORD TYPE, SOURCE, DESTINATION
A, ruby-lang.org, 221.186.184.75s
A, google.com, 172.217.163.46

CNAME, www.ruby-lang.org, ruby-lang.org 
CNAME, mail.google.com, google.com
CNAME, gmail.com, mail.google.com
```

### Sample output for the above zone file:
```
$ ruby lookup.rb google.com
google.com => 172.217.163.46$ 

ruby lookup.rb gmail.com
gmail.com => mail.google.com => google.com => 172.217.163.46

$ ruby lookup.rb gmil.com
Error: record not found
```

