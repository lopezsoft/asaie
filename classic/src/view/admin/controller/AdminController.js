/**
 * Created by LOPEZSOFT2 on 10/12/2016.
 */
Ext.define('Admin.view.admin.controller.AdminController',{
    extend  : 'Admin.base.BaseController',
    alias   : 'controller.admin',

    init: function () {
        me = this;
        me.setConfigVar();
    },
    
    onCreateDirGrupo : function (btn) {
        var me = this.app;
            me.onStore('general.GradosStore');
            me.onStore('admin.DirGrupoStore');
        this.redirectTo('groupmanagers', true);
    },

    onCreateAdmin : function (btn) {
        this.redirectTo('admins', true);
    },

    onCreateTeachers : function (btn) {
        this.redirectTo('teachers', true);
    },

    onCreateSchoolHeadquarters : function (btn) {
        this.redirectTo('schoolheadquarters', true);
    },

    onCreateSchool : function (btn) {
       this.redirectTo('schoolinformation', true);
    },
    /**
     * Funcion para setear los datos que se enviar al servidor para lamar el reporte.
     * @param btn
     */
    onSetReport: function(btn){
        var url     = 'reports/report_dir_grupos',
            win     = btn.up('window'),
            param   = {

            };
        this.onGenReport(btn,url,param);
    }
});
