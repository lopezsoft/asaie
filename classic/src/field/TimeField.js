Ext.define('Admin.field.TimeField',{
    extend      : 'Ext.form.field.Time',
    msgTarget	: 'side',
    fieldLabel  : 'Hora',
    minValue    : '06:00 AM',
    maxValue    : '11:59 PM',
    increment   : 1,
    selectOnFocus  : true,
    labelWidth	: 180,
    labelAlign	: 'top',
    labelStyle	: 'font-weight:bold',
    width 		: '100%',
    allowBlank 	: false,
    alias       : 'widget.timeField',
    xtype       : 'customtime',
    emptyText 	: 'Campo obligatorio',
    tooltip 	: '',
    listeners: {
        'focus' : function (textField, event, eOpts) {
            var me = this;
            if (!Ext.isEmpty(this.tooltip)) {
                new Ext.ToolTip({
                    target : this.id,
                    trackMouse : true,
                    maxWidth : 300,
                    minWidth : 100,
                    html : '<p align="justify">'+ this.tooltip +'</p>'
                });
            }
        }
    }
});