'use strict';

const icon = require('./icon.png')
const rot = require('rot')

const plugin = ({term, display, actions}) => {
    const match = term.match(/rot\s(.*)/)
    if (match) {
        const valueToRot= match[1]
        if (valueToRot) {
            const rottedValue = rot(valueToRot)
            const id = `cerebro-rot-${rottedValue}`

            display({
                title: `rot13(${valueToRot}) = ${rottedValue}`,
                id,
                icon,
                clipboard: rottedValue,
                subtitle: 'Press enter to copy value to clipboard',
                onSelect: () => {
                    actions.copyToClipboard(rottedValue)
                }
            })
        }
    }
};

module.exports = {
  fn: plugin,
  name: 'Encode input with rot13',
  keyword: 'rot',
  icon
}
