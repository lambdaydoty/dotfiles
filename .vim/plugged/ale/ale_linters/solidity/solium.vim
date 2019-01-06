" Author: Jeff Sutherland - https://github.com/jdsutherland
" Description: Report errors in Solidity code with solium

call ale#linter#Define('solidity', {
\   'name': 'solium',
\   'executable': './node_modules/.bin/solium',
\   'command': './node_modules/.bin/solium --reporter gcc --file %t',
\   'callback': 'ale#handlers#gcc#HandleGCCFormat',
\})
