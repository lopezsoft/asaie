/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.CandidaturasCrudView',{
    extend      : 'Admin.base.WindowCrud',
    title       : 'Ficha de candidaturas',
    controller  : 'personero',
    alias       : 'widget.CandidaturasCrudView',
    requires    : [
        'Admin.view.personero.CandidaturaView',
        'Admin.store.personero.CandidaturaStore'
    ],
    maximized   : true,
    items       : [
        {
            xtype   : 'customgrid',
            iconCls : '',
            store   : 'CandidaturaStore',
            columns : [
                {
                    xtype   : 'rownumberer'
                },
                {
                    dataIndex   : 'ID',
                    text        : 'id',
                    width       : 40
                },
                {
                    dataIndex   : 'candidatura',
                    text        : 'Nombre de la candidatura',
                    flex        : 2
                },
                {
                    xtype   : 'booleancolumn',
                    text    : 'Activa',
                    trueText: 'Si',
                    falseText: 'No',
                    dataIndex: 'estado'
                }
            ],
            dockedItems : [
                {
                    xtype   : 'pagination'
                },
                {
                    xtype   : 'toolbarCrud'
                }
            ]
        }
    ]
});