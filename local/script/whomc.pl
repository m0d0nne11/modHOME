#!/u/bin/perl

# 30-Oct-96 hpsiegel; Extract information from phone_list.html also,
#		and add filtering
# 15-Oct-96 hpsiegel; Created

# PURPOSE
#	Extract username information from `ypcat hosts` or, if
#	the '-local' option is used, "/etc/passwd".

# Parse the command line
if ($ARGV[0] =~ /^-h/) {
    print "USAGE: $0 [-local] [<pattern> ...]";
    exit (0);
}
$local = 0;
if ($ARGV[0] =~ /^-l/) {
    $local = 1;
    shift;
}


# Process information from the Mercury WWW phone list
#$phone = "/n/source/www_server_root/www_files/nitty-gritty/phone+email/phone_list.html";
$phone = "/n/source/www_server_root/publish/nitty-gritty/associates/associates.html";
open (PHONE, $phone) or die "Can't open $phone: $!\n";
while (<PHONE>) {
    if (m"^[^ \t]+, .*\.\.x") {
	s"\." "g;
	s"," ";
	@phone = split (' ');
	$key = "$phone[0] $phone[1]";
	$phone	{$key} = sprintf "  %4s, %4s", $phone[2], $phone[3];
	$name	{$key} = "$phone[1] $phone[0]";
    }
}
close (PHONE);


# Now process passwd information

# Open the correct input dataset
if ($local) {
    open (IN, "/etc/passwd")
		or die "Can't read from /etc/passwd: $!";
}
else {
    open (IN, "ypcat passwd |")
		or die "Can't read from 'ypcat passwd': $!";
}

# Process the lines from the input
while (<IN>) {
    ($uname, $passwd, $uid, $gid, $fullname, $home, $shell)
		= split (/:/);
    if ($fullname !~ m"[ \t]") {
	$key = $fullname;
    }
    elsif ($fullname =~ m"account"i) {
	$key = "(Account) $fullname";
    }
    elsif ($fullname =~ m"consultant"i) {
	$key = "(Consultant) $fullname";
    }
    else {
	$fullname =~ m"(.*) ([^ ]*)";
	$key = "$2 $1";
    }
    $passwd	{$key} = sprintf "%6d  %-10s", $uid, $uname;
    $name	{$key} = $fullname;
}

# All done with the input
close (IN);


# Print the header
print "   uid  username      phone\n";
print "   ---  --------    ----------\n";

# Collect all the keys from both %phone and %passwd
@keys = ((keys %phone), (keys %passwd));
# Display their information, sorted by name
foreach $key (sort @keys) {
    $flag = 0;
    if ($passwd{$key} ne "") {
	$line = $passwd{$key};
	$passwd{$key} = "";
	$flag = 1;
    }
    else {
	$line = " " x 18;
    }
    if ($phone{$key} ne "") {
	$line .= $phone{$key};
	$phone{$key} = "";
	$flag = 1;
    }
    else {
	$line .= " " x 12;
    }
    $line .= "  $name{$key}\n";
    if ($flag) {
	if ($#ARGV < 0) {
	    print $line;
	}
	else {
	    foreach $pattern (@ARGV) {
		print $line if $line =~ m"$pattern"i;
	    }
	}
    }
}

