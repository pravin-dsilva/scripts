#!/bin/bash
ibmcloud login
for i in rdr-ocp-upi-validation-syd04 rdr-ocp-upi-validation-tor01 rdr-ocp-upi-validation-tok04 rdr-ocp-upi-validation-syd05 rdr-ocp-upi-validation-osa21 rdr-ocp-upi-validation-sao01 rdr-ocp-upi-validation-lon06
do
echo "==========================================================================="
echo "=====================Region: ${i}========================"
echo "==========================================================================="
CRN=`ibmcloud pi sl | grep  $i | cut -d " " -f1`
ibmcloud pi st $CRN
VMS=`ibmcloud pi ins |awk "(NR>1)" |  awk '{print $2}' | wc -l`
echo "****Number of VM's: $VMS ****"
ibmcloud pi ins  |awk "(NR>1)" |  awk '{print $2}'
done
echo "IPI USAGE:"
for i in rdr-ocp-ipi-validation-lon06
do
echo "==========================================================================="
echo "=====================Region: ${i}========================"
echo "==========================================================================="
CRN=`ibmcloud pi sl | grep  $i | cut -d " " -f1`
ibmcloud pi st $CRN
VMS=`ibmcloud pi ins |awk "(NR>1)" |  awk '{print $2}' | wc -l`
echo "****Number of VM's: $VMS ****"
ibmcloud pi ins  |awk "(NR>1)" |  awk '{print $2}'
done
