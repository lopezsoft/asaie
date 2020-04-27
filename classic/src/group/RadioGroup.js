/**
 * Created by LOPEZSOFT on 10/02/2016.
 */
Ext.define('Admin.group.RadioGroup',{
    extend      : 'Ext.form.RadioGroup',
    labelStyle	: 'font-weight:bold',
    labelWidth	: 180,
    alias       : 'widget.radioGroup',
    xtype       : 'customradiogroup',
    msgTarget	: 'side',
    allowBlank  :false,
    columns     : 1,
    vertical    : true
});