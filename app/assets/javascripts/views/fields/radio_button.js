Seanchai.RadioButton = Ember.View.extend({
  instrumentDisplay: '{{input type="text"}}',

  classNames: ['ember-text-field'],
  tagName: "input",
  attributeBindings: ['type', 'checked', 'value', 'size', 'pattern', 'name', 'min', 'max',
    'accept', 'autocomplete', 'autosave', 'formaction',
    'formenctype', 'formmethod', 'formnovalidate', 'formtarget',
    'height', 'inputmode', 'list', 'multiple', 'step',
    'width'],

  /**
   The `value` attribute of the input element. As the user inputs text, this
   property is updated live.

   @property value
   @type String
   @default ""
   */
  value: "",

  options: null,

  /**
   The `type` attribute of the input element.

   @property type
   @type String
   @default "text"
   */
  type: "radio",

  /**
   The `size` of the text field in characters.

   @property size
   @type String
   @default null
   */
  size: null,

  /**
   The `checked` attribute of input element.

   @property checked
   @type Boolean
   @default false
   */
  checked: false,

  /**
   The `pattern` attribute of input element.

   @property pattern
   @type String
   @default null
   */
  pattern: null,

  /**
   The `min` attribute of input element used with `type="number"` or `type="range"`.

   @property min
   @type String
   @default null
   @since 1.4.0
   */
  min: null,

  /**
   The `max` attribute of input element used with `type="number"` or `type="range"`.

   @property max
   @type String
   @default null
   @since 1.4.0
   */
  max: null,

  click: function(event) {
    this.set('parentView.value', this.get('value'));
  }
});