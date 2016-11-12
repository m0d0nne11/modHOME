#!/bin/sh
# \
exec tclsh $0 ${@+"$@"}

#!/usr/bin/tclsh XXX_MIKE_DEBUG added lines above to accomplish the "Tcl trick"

# Lookup hostname and Base DN
#set hostname "llph"
#set hostname "cashbox"
set hostname "llemail"
set basedn "o=MIT_LINCOLN_LABORATORY"
#set basedn "o=TEMP"
#set hostname "lladdc02"
#set basedn "dc=mitll,dc=ad,dc=local"

set separator "----------------------------------------"

if { $argc == 0 } {
  puts "Usage: "
  puts "  Special handle options are:"
  puts "    phone="
  puts "    room="
  puts "    group="
  puts "    email="
  puts "      uid="
  puts "    pernr="
  puts "  Anything else is part of a name."
  puts "  For now, we are lazy, no spaces please."
  puts "Examples:"
  puts "  ph phone=3218"
  puts "  ph robert"
  puts "  ph room=B143"
} else {
  set searchstring "(&"
  foreach arg $argv {
    if { [regexp {=} $arg] } {
      set special [split $arg {=}]
      switch [lindex $special 0] {
        "phone" {
          set searchstring "$searchstring\(telephonenumber=*[lindex $special 1]*)"
        } "room" {
          set searchstring "$searchstring\(roomnumber=*[string toupper [lindex $special 1]]*)"
        } "group" {
          set searchstring "$searchstring\(departmentNumber=*[string toupper [lindex $special 1]]*)"
#         set searchstring "$searchstring\(group=*[string toupper [lindex $special 1]]*)"
        } "badge" {
          set searchstring "$searchstring\(employeeNumber=*[string toupper [lindex $special 1]]*)"
        } "email" {
          set searchstring "$searchstring\(mail=*[string toupper [lindex $special 1]]*)"
        } "uid" {
          set searchstring "$searchstring\(uid=*[string toupper [lindex $special 1]]*)"
        } "pernr" {
          set searchstring "$searchstring\(workforceID=*[string toupper [lindex $special 1]]*)"
        }
      }
    } else {
      set searchstring "$searchstring\(cn=*[string toupper $arg]*)"
    }
  }
  puts "Search command: /usr/bin/ldapsearch -x -L -h $hostname -b $basedn $searchstring)"
  set output    [open "|/usr/bin/ldapsearch -x -L -h $hostname -b $basedn $searchstring)" "r"]
  set new 0
  while { [gets $output line] != -1 } {
    puts "XXX_MIKE: $line"
#   if { [string match "dn: *" $line] == 1 } {
#     puts $separator
#   } elseif { [string match "cn: *" $line] == 1 } {
#     puts "     name:[lindex [split $line ":"] 1]"
#   } elseif { [string match "employeeNumber: *" $line] == 1 } {
#     puts "    badge:[lindex [split $line ":"] 1]"
#   } elseif { [string match "title: *" $line] == 1 } {
#     puts "    title:[lindex [split $line ":"] 1]"
#   } elseif { [string match "ou: *" $line] == 1 } {
#     puts "    group:[lindex [split $line ":"] 1]"
#   } elseif { [string match "telephoneNumber: *" $line] == 1 } {
#     puts "    phone:[lindex [split $line ":"] 1]"
#   } elseif { [string match "roomNumber: *" $line] == 1 } {
#     puts "     room:[lindex [split $line ":"] 1]"
#   } elseif { [string match "uid: *" $line] == 1 } {
#     puts "   UserID:[lindex [split $line ":"] 1]"
#   } elseif { [string match "mail: *" $line] == 1 } {
#     puts "    email:[lindex [split $line ":"] 1]"
#   } elseif { [string match "workforceID: *" $line] == 1 } {
#     puts "    pernr:[lindex [split $line ":"] 1]"
#   }
  }
  puts $separator
  close $output
  unset output
  unset line
}
