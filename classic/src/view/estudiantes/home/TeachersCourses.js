Ext.define('Admin.view.estudiantes.home.TeachersCourses', {
    extend          : 'Ext.panel.Panel',
    uses: [
        'Ext.layout.container.Border',
        'Ext.layout.container.Fit'
    ],
    config          :  {
        record          : null
    },
    alias       : 'widget.teacherscourses',
    controller  : 'estudiantes',
    cls         : 'quarterly-main',
    userCls     : 'small-100 big-100',
    flex        : 1,
    layout: {
        type    : 'vbox',
        align   : 'stretch'
    },
    scrollable: 'y',
    initComponent : function(){
        Admin.getApplication().onStore('estudiantes.DocentesCursoSocketStore');
        let me = this;
        me.items    = [
            {
                xtype       : 'dataview',
                store       : 'DocentesCursoSocketStore',
                liveDrag    : true,
                overItemCls : 'phone-hover',
                cls         : 'quarterly-dataview',
                itemSelector: 'div.thumb-wrap',
                tpl: [
                    '<tpl for=".">',
                        // Break every four quarters
                        '<tpl if="xindex % 1 === 1">',
                            '<div class="statement-type">{year} </div>',
                        '</tpl>',
                        
                        '<div class="thumb-wrap">',
                        '<div class="thumb">',
                            '<div class="statement-header">{grado} - {grupo} - {jornada} - {asignatura}</div>',
                            '<div class="thumb-icon"></div>',
                                '<div class="thumb-title-container">',
                                    '<div class="thumb-title">{nombres}</div>',
                                    '<div class="thumb-title-small">SEDE: {sede}</div>',
                                '</div>',
                                '<a class="thumb-return" href="#dashboard" target="_self"></a>',
                            '</div>',
                        '</div>',
                    '</tpl>'
                ],
                listeners   : {
                    scope           : this,
                    select          : this.select,
                    deselect        : this.deselect
                }
            }
        ],
        me.tbar = [
            {
                xtype       : 'customtext',
                name        : 'filter',
                fieldLabel  : '',
                labelWidth  : 2,
                flex        : 1,
                listeners: {
                    scope : this,
                    buffer: 200,
                    change: this.filter
                }
            },'-',
            '->',
            {
                iconCls     : 'fas fa-sync-alt',
                ui          : 'header-blue',
                handler     : function(btn){
                    if(btn.up('panel').down('dataview')){
                        btn.up('panel').down('dataview').getStore().reload();
                    }
                }
            },'-',
            {
                text    : 'Información docente',
                iconCls : 'fas fa-chalkboard-teacher',
                ui      : 'header-blue',
                itemId  : 'viewteacherinfo',
                disabled: true,
                tooltip : 'Ver datos del docente'
                // handler : 'viewTeacherinfo'
            },'-',
            {
                xtype       : 'closebutton'
            }
        ];
        this.callParent(arguments);
        this.setTitle('Docentes de curso');
        Ext.getStore('DocentesCursoSocketStore').reload();
    },
    select      : function(view, record){
        this.setRecord(record);
        this.down('#viewteacherinfo').setDisabled(false);
    },
    deselect    : function(view, record){
        this.down('#viewteacherinfo').setDisabled(false);
    },
    /**
     * @private
     * Called whenever the user types in the Filter textfield. Filters the DataView's store
     */
    filter: function(field, newValue) {
        let view        = this.down('dataview'),
            store       = view.getStore(),
            selModel    = view.getSelectionModel(),
            selection   = selModel.getSelection()[0];
        store.getFilters().replaceAll({
            property: 'estudiante',
            anyMatch: true,
            value   : newValue
        });
        if (selection && store.indexOf(selection) === -1) {
            selModel.clearSelections();
        }
    }
});