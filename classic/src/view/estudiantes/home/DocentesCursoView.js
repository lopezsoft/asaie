/**
 * Created by LOPEZSOFT on 14/02/2016.
 */
Ext.define('Admin.view.estudiantes.home.DocentesCursoView', {
    extend: 'Admin.panel.Panel',
    uses: [
        'Ext.layout.container.Border',
        'Ext.form.field.Text',
        'Ext.form.field.ComboBox',
        'Ext.toolbar.TextItem',
        'Ext.layout.container.Fit',
        'Admin.store.estudiantes.DocentesCursoSocketStore'
    ],
    alias               : 'widget.DocentesCursoView',
    title               : 'Docentes de curso',
    controller          : 'estudiantes',
    collapsed           : false,
    collapseDirection   : 'top',
    collapsible         : false,
    titleCollapse       : false,
    items       : [
        {
            xtype   : 'customgrid',
            height  : 500,
            store   : 'DocentesCursoSocketStore',
            iconCls : '',
            plugins	: [
                {
                    ptype: 'rowexpander',
                    selectRowOnExpand : true,
                    rowBodyTpl : new Ext.XTemplate(
                        '<div class="thumb-wrap">',
                        '<div class="thumb">',
                        '<img alt="{nombres}" src="{foto}"/>',
                        '</div>',
                        '<span>{nombres}</span>',
                        '</div>'
                    )
                },
                {
                    ptype			: 'gridSearch',
                    readonlyIndexes	: ['note'],
                    disableIndexes	: ['pctChange'],
                    minChars		: 1,
                    mode            : 'local',
                    flex			: 1,
                    autoFocus		: true,
                    independent		: false
                }
            ],
            columns: [
                {
                    xtype	: 'customrownumberer'
                },
                {
                    dataIndex   : 'foto',
                    text        : 'Fotografía',
                    width       : 142,
                    renderer    : function (val) {
                        var im;
                        if (Ext.isEmpty(val)){
                            im  = globales.General.avatarUnknoun;
                        }else{
                            im  = val;
                        }
                        return '<img alt="{nombres}" height="128" width="128" src="'+im+'"/>';
                    }
                },
                {
                    dataIndex   : 'nombres',
                    text        : 'Docente',
                    width       : 300
                },
                {
                    text    	: "Grado",
                    width       : 100,
                    sortable	: true,
                    dataIndex	: 'grado'
                },
                {
                    text		: "Grupo",
                    width		: 65,
                    sortable	: true,
                    dataIndex	: 'grupo'
                },
                {
                    text		: "Asignatura",
                    width		: 300,
                    sortable	: true,
                    dataIndex	: 'asignatura'
                },
                {
                    text		: "Jornada",
                    width		: 100,
                    sortable	: true,
                    dataIndex	: 'jornada'
                },
                {
                    text		: "Sede",
                    width		: 300,
                    sortable	: true,
                    dataIndex	: 'sede'
                },
                {
                    text		: "Correo",
                    width		: 300,
                    sortable	: true,
                    dataIndex	: 'e_mail'
                },
                {
                    text		: "Celular",
                    width		: 100,
                    sortable	: true,
                    dataIndex	: 'movil'
                },
                {
                    text		: "Año",
                    width		: 60,
                    dataIndex	: 'año'
                }
            ],
            listeners: {
                resize: function (grid, width, height, oldWidth, oldHeight, eOpts ){
                    if (width <=400) {
                        grid.getColumns()[4].setHidden(true);
                        grid.getColumns()[5].setHidden(true);
                        grid.getColumns()[6].setHidden(true);
                    }else if (width <=700){
                        grid.getColumns()[4].setHidden(false);
                        grid.getColumns()[5].setHidden(true);
                        grid.getColumns()[6].setHidden(true);
                    }else {
                        grid.getColumns()[4].setHidden(false);
                        grid.getColumns()[5].setHidden(false);
                        grid.getColumns()[6].setHidden(false);
                    }
                }
            },
            tbar: [
                {
                    xtype   : 'facebookButton'
                },
                {
                    xtype   : 'youtubeButton'
                }
            ]
        }
    ]
});