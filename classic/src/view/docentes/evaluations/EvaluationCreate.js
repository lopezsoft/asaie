Ext.define('Admin.view.docentes.EvaluationCreate', {
    extend: 'Ext.panel.Panel',
    requires: [
        'Ext.ux.layout.ResponsiveColumn'
    ],
    bodyPadding : 0,
    cls         : 'kpi-main',
    xtype       : 'evaluationcreate',
    layout      : 'responsivecolumn',
    alias       : 'widget.evaluationcreate',
    reference   : 'evaluationcreate',

    config: {
        activeState     : null,
        record          : null,
        totalQuestions  : 0,
        newItems        : []
    },
    controller: 'actividades',
    scrollable  : 'y',
    minWidth    : 600,
    initComponent : function(){
        let 
            me      =  this,
            record  = me.getRecord();
        if(!record){
            me.getController().redirectTo('evaluaciones', true);
        }else{
            me.items = me.getNewItems();
        }
        me.callParent(arguments);
    },
    dockedItems:[{
        xtype   : 'customtoolbar',
        dock    : 'top',     
        items: [
            '->',
            {
                xtype       : 'closebutton'
            }
        ]
    }],
    validStates: {
        clicks: 1,
        redemption: 1,
        sales: 1,
        goalsmet: 1
    },

    isValidState: function (state) {
        return state in this.validStates;
    }
});