/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.view.academico.NotasReportadasView',{
    extend  : 'Admin.form.FormBase',
    alias   : 'widget.notasReportadas',
    xtype   : 'notasReportadas',
    itemId : 'NotasReportadasView',
    controller      : 'academico',
    initComponent: function () {
        var me  = Admin.getApplication();
        me.onStore('general.GradosStore');
        me.onStore('admin.DocentesDirGrupoStore');
        me.onStore('general.PeriodosStore');
        this.callParent(arguments);
        this.setTitle(AppLang.getSTitleViewReportedNotes() + ' - ' + Global.getYear());
    },
    showSaveButton    : false,
    items: [
        {
            xtype: 'customgrid',
            flex: 2,
            title: 'ASIGNACIÓN ACADÉMICA',
            itemId  : 'gridCarga',
            store: 'DocentesDirGrupoStore',
            allowDeselect : true,
            plugins		: [
                {
                    ptype : 'gridfilters'
                },
                {
                    ptype : 'responsive'
                },
                {
                    ptype			: 'gridSearch',
                    readonlyIndexes	: ['note'],
                    disableIndexes	: ['pctChange'],
                    minChars		: 1,
                    mode            : 'local',
                    flex			: 1,
                    autoFocus		: true,
                    independent		: true
                }
            ],
            columns: [
                {
                    xtype: 'customrownumberer'
                },
                {
                    text: 'DOCENTES',
                    dataIndex: 'nombres',
                    flex: 1,
                    filter: 'string'
                },
                {
                    text: 'Año',
                    dataIndex: 'year',
                    width: 55
                }
            ],
            dockedItems: [
                {
                    xtype: 'toolbarCrud',
                    items: [
                        {
                            xtype: 'CbPeriodos',
                            width: 160,
                            labelAlign : 'left'
                        },
                        {
                            xtype   : 'printButton'
                        },
                        '->',
                        {
                            xtype: 'closebutton',
                            iconAlign	: 'left'
                        }
                    ]
                },
                {
                    xtype: 'pagination',
                    itemId: 'pToolbar'
                }
            ]
        }
    ]
});
