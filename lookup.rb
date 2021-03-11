# Recursive DNS Resolver

def get_command_line_argument
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

domain = get_command_line_argument
dns_raw = File.readlines("zone")

# To check if a line is empty or commented
def lineExists(line)
  line = line.strip

  if line[0] == "#" || line[0].nil?
    return false
  else
    return true
  end
end

def parse_dns(dns_raw)
  dns_records = {}
  dns_raw.each { |line|
    if lineExists(line)
      line = line.split(",").map { |word| word.strip }
      type = line[0]
      domain = line[1]

      dns_records[domain] = {
        :type => type,
        :value => line[2],
      }
    end
  }

  return dns_records
end

def resolve(dns_records, lookup_chain, domain)
  if dns_records.has_key? domain
    value = dns_records[domain][:value]
    lookup_chain.push(value)

    if dns_records[domain][:type] == "CNAME"
      resolve(dns_records, lookup_chain, value)
    end
  else
    lookup_chain.push("Error: record not found!")
  end
  return lookup_chain
end

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
