#!/bin/bash


# get opts::
i=0
skrypt='cat /proc/buddyinfo'
plik=''
node='Normal'
zone='Node 0'

while getopts ":asf:n:z:" arg; do
    case ${arg} in
    s) i=1;;
    f) plik="$OPTARG";;
    z) node="$OPTARG";;
    n) zone="$OPTARG";;
    a) ;;
    esac
done
shift $((OPTIND-1))

#awks :::
[[ -n $plik ]] && skrypt="cat $plik" || echo "komenda nei zadzialala" 
zone="$zone,"
zone=`echo $zone | awk -F " " '{if($1=="Node") {print $2}}'`
[[ $i == 1 ]] && $skrypt | awk -F " " '{ for(i=5;i<=NF;i++) {if($2=="'$zone'" && $4=="'$node'") {printf("%d %d %.2f\n",i-5,$i,2^(i-5)*4096*$i/2^20);a+=2^(i-5)*4096*$i/2^20}}} END{printf("%.2f\n",a)}' 
[[ $i == 0  && -n $1 ]] && $skrypt | awk -F " " '{ for(i=5;i<=NF;i++) {if($2=="'$zone'" && $4=="'$node'") {printf("%d %d %.2f\n",i-5,$i,2^(i-5)*4096*$i/2^20);a+=2^(i-5)*4096*$i/2^20}}}' | awk '{if($1=="'$1'") {print}}'
###########
x=`awk -F " : " '{print $1}' /proc/iomem | tr a-f A-F` #nowork
a=`echo "ibase=16; $x" | bc | tr ' ' '\n' ` #to B
if [ $i == 1 ]; then
    paste <(awk -F " : " '{print $2":"}' /proc/iomem) <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}')  <(echo "scale=8; $(awk '{print $1"/1024/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{printf "%.4f MB\n", $0}') | tr '-' ' '  
else if [ $i == 2 ]; then
    paste <(awk -F " : " '{print $2":"}' /proc/iomem) <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}')  <(echo "scale=8; $(awk '{print $1"/1024/1024/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{printf "%.4f GB\n", $0}') | tr '-' ' '  
else
    paste <(awk -F " : " '{print $2":"}' /proc/iomem) <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}')  <(echo "scale=8; $(awk '{print $1"/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{printf "%.4f KB\n", $0}') | tr '-' ' '  
fi
fi
##############
ls -l /dev4d | awk -F" " '{if(substr($1,1,1)=="b" && $5 == "'$1',"){printf("%c %d %d /dev4d/%s\n",substr($1,1,1),$5,$6,$10)}}' | sort -k 3n
ls -l /dev4d | awk -F" " '{if(substr($1,1,1)=="c" && $5 == "'$1',"){printf("%c %d %d /dev4d/%s\n",substr($1,1,1),$5,$6,$10)}}' | sort -k 3n 
##############
echo "CPU hogs:"
$skrypt | tail -n +2 | sort -n -k 4 -r  | awk -F " " -v var="$i" '{if (NR<=var) {print}}'
echo ""
echo "RES hogs:"
$skrypt | tail -n +2 | sort -n -k 3 -r | awk -F " " -v var="$i" '{if (NR<=var) {print}}'
echo ""
echo "VIRT hogs:"
$skrypt | tail -n +2 | sort -n -k 2 -r | awk -F " " -v var="$i" '{if (NR<=var) {print}}'
##############
[[ -n $plik ]] && skrypt="cat $plik"
[[ -n $user ]] && $skrypt | tail -n +2 | awk '{if($1=="'$user'"){print}}' | awk '{print $2, $6}' | awk 'BEGIN{s=0;t=0;d=0;r=0;z=0}{if($1=="S"){s+=$2}; if($1=="T"){t+=$2}; if($1=="D"){d+=$2}; if($1=="R"){r+=$2}; if($1=="Z"){Z+=$2}}END{printf("I=%d\n",i); printf("R=%d\n",r); printf("S=%d\n",s); printf("T=%d\n",t); printf("Z=%d\n",z)} ' || $skrypt | tail -n +2 | awk '{print $2, $6}' | awk 'BEGIN{s=0;t=0;d=0;r=0;z=0}{if($1=="S"){s+=$2}; if($1=="T"){t+=$2}; if($1=="D"){d+=$2}; if($1=="R"){r+=$2}; if($1=="Z"){Z+=$2}}END{printf("I=%d\n",i); printf("R=%d\n",r); printf("S=%d\n",s); printf("T=%d\n",t); printf("Z=%d\n",z)} '
#############
if [[ $i == 0 ]]; then
paste <($skrypt | tail -n +2 | awk '{print $1}' | awk '{ a[$1]++ } END{ for(x in a) print a[x], x }' | awk '{print $2, $1}' | sort -u)  <($skrypt | tail -n +2 | awk '{ seen[$1] += $4 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') <($skrypt | tail -n +2 | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') | sort -n -k 3 -r | expand -t 15
else if [[ $i == 1 ]]; then
paste <($skrypt | tail -n +2 | awk '{if ($2<=999) {print $1}}' | awk '{ a[$1]++ } END{ for(x in a) print a[x], x }' | awk '{print $2, $1}' | sort -u)  <($skrypt | tail -n +2 | awk '{if ($2<=999) {print}}' | awk '{ seen[$1] += $4 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') <($skrypt | tail -n +2 | awk '{if ($2<=999) {print}}' | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') | sort -n -k 3 -r | expand -t 15
else if [[ $i == 2 ]]; then
paste <($skrypt | tail -n +2 | awk '{if ($2>999) {print $1}}' | awk '{ a[$1]++ } END{ for(x in a) print a[x], x }' | awk '{print $2, $1}' | sort -u)  <($skrypt | tail -n +2 | awk '{if ($2>999) {print}}' | awk '{ seen[$1] += $4 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') <($skrypt | tail -n +2 | awk '{if ($2>999) {print}}' | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') | sort -n -k 3 -r | expand -t 15
fi
fi
fi
############
awk 'NR % 6'            # prints all lines except those divisible by 6
awk 'NR > 5'            # prints from line 6 onwards (like tail -n +6, or sed '1,5d')
awk '$2 == "foo"'       # prints lines where the second field is "foo"
awk 'NF >= 6'           # prints lines with 6 or more fields
awk '/foo/ && /bar/'    # prints lines that match /foo/ and /bar/, in any order
awk '/foo/ && !/bar/'   # prints lines that match /foo/ but not /bar/
awk '/foo/ || /bar/'    # prints lines that match /foo/ or /bar/ (like grep -e 'foo' -e 'bar')
awk '/foo/,/bar/'       # prints from line matching /foo/ to line matching /bar/, inclusive
awk 'NF'                # prints only nonempty lines (or: removes empty lines, where NF==0)
awk 'NF--'              # removes last field and prints the line
awk '$0 = NR" "$0'      # prepends line numbers (assignments are valid in conditions)
#############
Another variable, FNR, stores the number of records read from the current file
being processed. The value of FNR starts from 1, increases until the end of the
current file, starts again from 1 as soon as the first line of the next file is read,
and so on. So, the condition "NR==FNR" is only true while awk is reading the first
file.
################
prints lines from /beginpat/ to /endpat/, not inclusive
awk '/endpat/{p=0};p;/beginpat/{p=1}'

prints lines from /beginpat/ to /endpat/, excluding /endpat/
awk '/endpat/{p=0} /beginpat/{p=1} p'

prints lines from /beginpat/ to /endpat/, excluding /beginpat/
awk 'p; /endpat/{p=0} /beginpat/{p=1}'
###################
"next" statement to tell awk to immediately start processing the next record.
#################
LC_ALL=C
###
echo "siema" | awk '{print toupper(substr($0,1,1)) substr($0,2)}'
###
tr a-z A-z
###
[[ -n $plik ]] && skrypt="cat $plik"

j=`$skrypt | awk '{ if (NR==1) {print}}' | sed 's/[^C]//g' | awk '{ {print length} }'`

if [[ $i == 0 ]]; then
$skrypt | awk -v x=$j '$1 ~ /^[0-9]+:/{for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,$1,$NF;a=0}'
$skrypt | awk -v x=$j '$1 ~ /LOC:/ {for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,"Local timer interrupts"}'
else
$skrypt | awk -v x=$j '$1 ~ /^[0-9]+:/ {for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,$1,$NF;a=0}' | sort -n -k 1 -r
$skrypt | awk -v x=$j '$1 ~ /LOC:/ {for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,"Local timer interrupts"}'
fi
#############
substr(string,start index,length)
######
paste <($skrypt | awk -F: '{print $1,$2,$3}' | tr ' ' ':') <($skrypt | awk -F : ' {split( $4, a, "," ); asort( a ); for( i = 1; i <= length(a); i++ ) printf( "%s ", a[i] ); printf( "\n" ); }' | tr ' ' ',') | tr '\t' ':'
###
awk '{split($0, array, ":")}'
#           \/  \___/  \_/
#           |     |     |
#       string    |     delimiter
#                 |
#               array to store the pieces
#################
variable:
$skrypt | tail -n +2 | sort -n -k 2 -r | awk -F " " -v var="$i" '{if (NR<=var) {print}}' | awk '{{printf $1 " "} {printf $2 " "} {printf $5 " \n"}}'
####
echo welcome | awk '{ for(i=length;i!=0;i--)x=x substr($0,i,1);}END{print x}'
####
echo welcome | rev
######
echo "4294967295" | awk '{printf("%X\n", $0)}'
#####
d or i	Signed decimal integer	392
u	Unsigned decimal integer	7235
o	Unsigned octal	610
x	Unsigned hexadecimal integer	7fa
X	Unsigned hexadecimal integer (uppercase)	7FA
f	Decimal floating point, lowercase	392.65
F	Decimal floating point, uppercase	392.65
e	Scientific notation (mantissa/exponent), lowercase	3.9265e+2
E	Scientific notation (mantissa/exponent), uppercase	3.9265E+2
g	Use the shortest representation: %e or %f	392.65
G	Use the shortest representation: %E or %F	392.65
a	Hexadecimal floating point, lowercase	-0xc.90fep-2
A	Hexadecimal floating point, uppercase	-0XC.90FEP-2
c	Character	a
s	String of characters	sample
p	Pointer address	b8000000
n	Nothing printed.
The corresponding argument must be a pointer to a signed int.
The number of characters written so far is stored in the pointed location.	
%	A % followed by another % character will write a single % to 
#####
kibibyte	KiB	2^10	kilobyte	KB	10^3
mebibyte	MiB	2^20	megabyte	MB	10^6
gibibyte	GiB	2^30	gigabyte	GB	10^9
tebibyte	TiB	2^40	terabyte	TB	10^12
pebibyte	PiB	2^50	petabyte	PB	10^15
exbibyte	EiB	2^60	exabyte	EB	10^18
#####
100 kilobytes (KB)	97.65 kibibytes (KiB)	2.35%
100 megabytes (MB)	95.36 mebibytes (MiB)	4.64%
100 gigabytes (GB)	93.13 gibibytes (GiB)	6.87%
100 terabytes (TB)	90.94 tebibytes (TiB)	9.06%
100 petabytes (PB)	88.81 pebibytes (PiB)	11.19%
100 exabytes (EB)	86.73 exbibytes (EiB)	13.27%
#####
echo "S,I,1,M,A" | awk '{split( $0, a, ","); for(i = 1; i <= length(a); i++){if(a[i]=='1'){ a[i]="A" }} for(i = 1; i <= length(a); i++) printf("%s \n", a[i])  }'
######





