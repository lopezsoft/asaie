/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.view.academico.inscripciones.FamiliaresView',{
    extend  : 'Admin.base.WindowCrud',
    alias   : 'widget.FamiliaresView',
    title   : 'Ficha familiares',
    controller: 'academico',
    initComponent: function () {
        Admin.getApplication().onStore('inscripciones.FamiliaresStore');
        this.callParent(arguments);
        this.setTitle(AppLang.getSTitleViewFamilies());
    },
    buildWindow: function () {
        var
            me = this.getApp();
        me.onStore('general.DocumentosStore');
        me.onStore('general.CountryStore');
        me.onStore('general.CiudStore');
        me.onStore('general.CiudStore2');
        me.onStore('general.CiudStore3');
        me.onStore('general.RHStore');
        me.onStore('general.PoblacionatendidaStore');
        me.onStore('inscripciones.ParentescoFamiliarStore');
        me.onStore('inscripciones.TipoFamiliarStore');
        this.winObject = Ext.create('Admin.view.academico.inscripciones.forms.FamiliaresFormView');
    },
    showWindow: function (btn) {
        var me = this.app,
            ts = this,
            data = ts.down('grid').getSelection()[0],
            form = [];
        Ext.require([
            'Admin.view.academico.inscripciones.forms.InscripcionesForm',
            'Admin.store.general.CiudStore2',
            'Admin.store.general.CiudStore3',
            'Admin.combo.CbPoblacionAtendida',
            'Admin.combo.CbCountries',
            'Admin.combo.CbRH',
            'Admin.combo.CbTipoFamiliar',
            'Admin.combo.CbParentescoFamiliar'
        ]);

        Ext.onReady(function () {
            if (!ts.getWinObject()) {
                ts.buildWindow();
            }
            form = ts.winObject.down('form');
            if (btn.itemId == 'editButton') {
                form.loadRecord(data);
                form.down('#CkAcud').setHidden(true);
            } else {
                form.reset(true);
                form.down('#CkAcud').setHidden(false);
            };
            ts.winObject.show();
        });
    },
    width   : 800,
    store   : 'FamiliaresStore',
    height  : '100%',
    showSaveButton : false,
    items   : [{
        xtype       : 'customgrid',
        store       : 'FamiliaresStore',
		plugins		: [
			{
				ptype: 'rowexpander',
				rowBodyTpl : new Ext.XTemplate(
					'<p><b>Familiares:</b> {nombres}</p>'
				)
			},
			{
				ptype			: 'gridSearch',
				readonlyIndexes	: ['note'],
				disableIndexes	: ['pctChange'],
				mode            : 'local',
				flex			: 1,
				autoFocus		: false,
				independent		: true
			}
		],
        columns     : [
            {
                xtype   : 'customrownumberer'
            },
            {
                text        : 'Número documento',
                dataIndex   : 'document',
                width       : 150
            },
            {
                text        : 'Familiares',
                dataIndex   : 'nombres',
                width       : 300
            },
            {
                text        : 'Teléfono',
                dataIndex   : 'mobile',
                width       : 120
            },
            {
                text        : 'Dirección',
                dataIndex   : 'address',
                width       : 250
            },
            {
                text        : 'Tipo Familiar',
                dataIndex   : 'family_type_name',
                width       : 130
            }
        ],
        dockedItems : [
            {
                xtype   : 'toolbarCrud',
                items   : [
                    {
                        xtype   : 'addButton'
                    },'-',
                    {
                        xtype   : 'editButton'
                    },'-',
                    {
                        xtype   : 'deletebutton'
                    },'-',
                    {
                        xtype   : 'closebutton'
                    }
                ]
            },
            {
                xtype 		: 'pagination',
                itemId		: 'pToolbar'
            }
        ]
    }]
});
