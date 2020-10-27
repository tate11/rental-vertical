#!/bin/bash

TOOLS=${TOOLS:-~/work/odoo-dev/tools}
ds=$(date "+%Y-%m-%d-%H-%M-%S")
GET_MANIFEST_INFO=${GET_MANIFEST_INFO:-${TOOLS}/get_openerp_info.py}

for p in ${@:-rental_* shipment*}; do
  echo "processing ${p}..."
  m=${p}/__manifest__.py
  docdir=${p}/README
  shtmldir=${p}/static/description
  shtmlfn=${shtmldir}/index.html
  descfn=${docdir}/DESCRIPTION.rst
  historyfn=${docdir}/HISTORY.rst
  usagefn=${docdir}/USAGE.rst
  contribfn=${docdir}/CONTRIBUTORS.rst
  mkdir -p ${docdir} || {
    echo "error: cannot create ${docdir}, continuing with next package..."
    continue
  }
  mkdir -p ${shtmldir} || {
    echo "error: cannot create ${shtmldir}, continuing with next package..."
    continue
  }
  if grep -q "'name'" ${m}; then
    name=$(${GET_MANIFEST_INFO} -f ${m} -a name -p '' | sed -e 's/^\.$//' -e 's/|//g')
  else
    echo "error: module name not found, continuing with next package..."
    continue
  fi
  if grep -q "'summary'" ${m}; then
    summary=$(${GET_MANIFEST_INFO} -f ${m} -a summary -p '' | sed -e 's/^\.$//' -e 's/|//g')
  else
    echo "error: module summary not found, continuing with next package..."
    continue
  fi
  if grep -q "'description'" ${m}; then
    description=$(${GET_MANIFEST_INFO} -f ${m} -a description -p '' | sed -e 's/^\.$//' -e 's/|//g')
  else
    description='TODO'
  fi
  if grep -q "'usage'" ${m}; then
    usage=$(${GET_MANIFEST_INFO} -f ${m} -a usage -p '' | sed -e 's/^\.$//' -e 's/|//g')
  else
    usage=''
  fi
  if grep -q "'contributors'" ${m}; then
    contributors=$(${GET_MANIFEST_INFO} -f ${m} -a contributors -p '' | sed -e 's/^\.$//' -e 's/|//g')
  else
    contributors=''
  fi
  if grep -q "'author'" ${m}; then
    author=$(${GET_MANIFEST_INFO} -f ${m} -a author -p '' | sed -e 's/^\.$//' -e 's/|//g')
  else
    author=''
  fi
  {
    echo ""
    echo "Changelog"
    echo "---------"
    echo ""
    git log --pretty=format:'%h %ad %ae %d %s' --date=iso -- ${p} | sed -e 's/^/- /'
    echo ""
  } > ${historyfn}
  {
    echo "${name}"
    echo "===================================================="
    echo ""
    echo "*This file has been generated on ${ds}. Changes to it will be overwritten.*"
    echo ""
    echo "Summary"
    echo "-------"
    echo ""
    echo "${summary}"
    echo ""
    echo "Description"
    echo "-----------"
    echo ""
    echo "${description}"
    echo ""
  } > ${descfn}
  if [[ -n "${usage}" ]]; then
    {
      echo ""
      echo "Usage"
      echo "-----"
      echo ""
      echo "${usage}"
      echo ""
    } > ${usagefn}
  fi
  if [[ -n "${author}" || -n "${contributors}" ]]; then
    {
      echo ""
      echo "Contributors"
      echo "------------"
      echo ""
      echo "${author}"
      echo "${contributors}"
      echo ""
    } > ${contribfn}
  fi
  if [[ ${p} == 'rental_sale' ]]; then
    allfn=${p}/README2.rst
  else
    allfn=${p}/README.rst
  fi
  cat ${descfn} ${usagefn} ${historyfn} > ${allfn}
  rst2html.py ${allfn} ${shtmlfn}
  git add ${docdir}
  git add ${shtmldir}
done
rm -f */*.tmp
