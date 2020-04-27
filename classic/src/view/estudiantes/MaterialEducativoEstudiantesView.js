/**
 * Created by LOPEZSOFT on 25/01/2016.
 */
Ext.define('Admin.view.estudiantes.MaterialEducativoEstudiantesView',{
    extend	: 'Admin.base.WindowCrud',
    requires: [
        'Admin.view.docs.VideoView',
        'Admin.store.estudiantes.MaterialEducativoEstudiantesStore',
        'Admin.grid.CustomGrid'
    ],
    title	: 'Material educativo',
    alias 	: 'widget.MaterialEducativoEstudiantesView',
    controller  : 'estudiantes',
    maximized   : true,
    items   : [
        {
            xtype       : 'customgrid',
            store		: 'MaterialEducativoEstudiantesStore',
            iconCls     : '',
            selModel	: 'rowmodel',
            plugins		: [
                {
                    ptype			: 'gridSearch',
                    readonlyIndexes	: ['note'],
                    disableIndexes	: ['pctChange'],
                    minChars		: 1,
                    mode            : 'local',
                    flex			: 1,
                    autoFocus		: false,
                    independent		: true
                }
            ],
            // Reusable actions
            actions: {
                leer: {
                    iconCls: 'x-fa fa-eye',
                    tooltip: 'Leer',
                    handler: function (grid, rowIndex, colIndex) {
                        var rec = grid.getStore().getAt(rowIndex),
                            app = Admin.getApplication(),
                            img = rec.get('foto'),
                            docente     = rec.get('docente'),
                            asignatura  = rec.get('asignatura') ? rec.get('asignatura') : 'resources/img/avatars/unknown.png';
                        console.log(img);
                        Ext.require('Admin.view.estudiantes.LeerMaterialView');
                        Ext.onReady(function () {
                            win     = Ext.create('Admin.view.estudiantes.LeerMaterialView',{
                                height  : 350,
                                title   : 'Material educativo',
                                items   :[
                                    {
                                        xtype   : 'form',
                                        items   : [
                                            {
                                                xtype: 'container',
                                                height: 82,
                                                layout: {
                                                    type: 'hbox',
                                                    align: 'stretch'
                                                },
                                                items: [
                                                    {
                                                        xtype   : 'image',
                                                        itemId  : 'userImage',
                                                        cls     : 'email-sender-img',
                                                        src     : img,
                                                        height  : 80,
                                                        width   : 80
                                                    },
                                                    {
                                                        xtype   : 'component',
                                                        flex    : 1,
                                                        cls     : 'single-mail-email-subject',
                                                        itemId  : 'emailSubjectContainer',
                                                        padding : 10,
                                                        html:
                                                            '<div class="user-name-d">'+docente+'</div>'+
                                                            '<div class="user-info-d">'+asignatura+' - '+rec.get('jornada')+'</div>'+
                                                            '<div class="user-info-d">'+rec.get('grado')+' - '+rec.get('grupo')+'</div>'+
                                                            '<div class="user-info-d">'+rec.get('sede')+'</div>'
                                                    }
                                                ]
                                            },
                                            {
                                                xtype   : 'box',
                                                cls     : 'mail-body',
                                                html:
                                                '<br>'+
                                                '<div class="user-name-d">'+rec.get('nombre')+'</div>'+
                                                '<div class="user-info-d">'+rec.get('descripcion')+'</div>'+
                                                '<a href="'+rec.get('url_archivo')+'" target="_blank"> Ver archivo adjunto</a><br>'+
                                                '<a href="'+rec.get('url_enlace')+'" target="_blank"> Abrir enlace de archivo</a><br>'+
                                                '<a href="'+rec.get('url_video')+'" target="_blank"> Abrir enlace de video</a>'
                                            }
                                        ]
                                    }
                                ]
                            });
                            win.show();
                        });
                        if (!rec.get('leido')) {
                            rec.set('leido',1);
                            grid.getStore().sync({
                                success : function (r, o) {
                                    var
                                        gb      = globales.General,
                                        socket  = gb.getSocket(),
                                        view    = Admin.getApplication().getMainView(),
                                        btn     = view.down('#btnDocs');
                                    socket.emit('sql-query-select',{
                                        cFields     : 'COUNT(id_material) total ',
                                        cTable      : 'material_educ_compartido',
                                        cWhereFields: 'id_matric = ? AND leido = ? ',
                                        cWhereValues: [rec.get('id_matric'),0]
                                    });
                                    socket.on('receiveSqlQuerySelect',function (d, e) {
                                        if (d) {
                                            if (d.length > 0) {
                                                var val   = d[0].total;
                                                if (val > 0 ){
                                                    cls  = 'x-btn-badgeCls';
                                                }else {
                                                    cls  = 'x-btn-badgeCls-green';
                                                }
                                                btn.setBadgeCls(cls);
                                                btn.setBadgeText(val.toString());
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    }
                },
                document: {
                    iconCls: 'x-fa fa-paperclip',
                    tooltip: 'Archivo adjunto',
                    handler: 'onDocument'
                },
                video: {
                    iconCls: 'x-fa fa-youtube-play',
                    tooltip: 'Ver video',
                    handler: 'onVideo'
                },
                url: {
                    iconCls: 'x-fa fa-link',
                    tooltip: 'Abrir enlace',
                    handler: 'onUrl'
                }
            },
            viewConfig: {
                getRowClass: function(record) {
                    return record.get('leido') == 1 ? 'letter-row' : 'no-letter-row';
                }
            },
            columns	: [
                {
                    xtype	: 'customrownumberer'
                },
                {
                    text    : 'Acciones',
                    columns : [
                        {
                            menuDisabled    : true,
                            sortable        : false,
                            xtype       : 'actioncolumn',
                            width       : 30,
                            items       : ['@leer']
                        },
                        {
                            menuDisabled    : true,
                            sortable        : false,
                            xtype       : 'actioncolumn',
                            width       : 30,
                            items       : ['@document']
                        },
                        {
                            menuDisabled    : true,
                            sortable        : false,
                            xtype       : 'actioncolumn',
                            width       : 30,
                            items       : ['@video']
                        },
                        {
                            menuDisabled    : true,
                            sortable        : false,
                            xtype       : 'actioncolumn',
                            width       : 30,
                            items       : ['@url']
                        }
                    ]
                },
                {
                    text        : 'Nombre',
                    width       : 300,
                    dataIndex   : 'nombre'
                },
                {
                    text 		: 'Descripción',
                    width 		: 300,
                    dataIndex	: 'descripcion'
                },
                {
                    text 		: 'Fecha publicación',
                    width 		: 135,
                    dataIndex	: 'fecha'
                },
                {
                    text 		: 'Grado',
                    width 		: 120,
                    dataIndex	: 'grado'
                },
                {
                    text 		: 'Grupo',
                    width 		: 60,
                    dataIndex	: 'grupo'
                },
                {
                    text 		: 'Jornada',
                    width 		: 100,
                    dataIndex	: 'jornada'
                },
                {
                    text 		: 'Asignatura',
                    width 		: 300,
                    dataIndex	: 'asignatura'
                },
                {
                    text 		: 'Docente',
                    width 		: 300,
                    dataIndex	: 'docente'
                },
                {
                    text 		: 'Sede',
                    width 		: 300,
                    dataIndex	: 'sede'
                }
            ],
            dockedItems: [
                {
                    xtype 		: 'pagination',
                    itemId		: 'pToolbar'
                },
                {
                    xtype       : 'customToolbar',
                    items       : [
                        '->',
                        {
                            xtype   : 'closebutton'
                        }
                    ]
                }
            ]
        }
    ]
});
