/**
 * Created by LOPEZSOFT on 21/05/2016.
 */
Ext.define('Admin.view.general.controller.ReportesController',{
    extend  : 'Admin.base.BaseController',
    alias   : 'controller.ReportesGeneral',

    init: function() {
        me  = this;

        me.setConfigVar();

        me.control({

        });
    },
    /**
     * Funcion para setear los datos que se enviar al servidor para lamar el reporte.
     * @param btn
     */
    onSetReport: function(btn){
        var url     = 'reports/report_consolidado',
            win     = btn.up('window'),
            values  = win.down('form').getValues(),
            param   = {
                pdbCodGrado : values.id_grado,
                pdbIdJorn   : values.cod_jorn,
                pdbGrupo    : values.grupo,
                pHojaReport : values.hoja,
                pTypeReport : values.id_report,
                pdbIdSede   : values.id_sede,
                pdbPeriodo  : values.periodo,
                pdbAllPer   : values.allper
            };
        this.onGenReport(btn,url,param);
        if (btn.itemId == 'btnXls'){
            this.onDownLoadReportXls(btn,url,param);
        }
    },

    onDownLoadReportXls: function (btn, url, param) {

        var me  	= this,
            cUrl	= Global.getUrlBase()+'c_excel_manager/download_report_consolidado',
            vMask;

        vMask = btn.up('window');

        if (Ext.isEmpty(vMask)){
            vMask   = btn.up('grid');
        }

        switch(btn.itemId){
            case 'btnHtml':
                xFormat = 'html';
                break;
            case 'btnRtf':
                xFormat = 'rtf';
                break;
            case 'btnXls':
                xFormat = 'xls';
                break;
            case 'btnDoc':
                xFormat = 'doc';
                break;
            case 'btnCsv':
                xFormat = 'csv';
                break;
            case 'btnPptx':
                xFormat = 'pptx';
                break;
            case 'btnPrint':
                xFormat = 'print';
                break;
            default	:
                xFormat = 'pdf';
                break;
        }


        if(!Ext.isEmpty(url) && btn.itemId == 'btnXls') {

            xParam  = param;

            Object.defineProperty(xParam,'pFormat',{
                value : xFormat,
                writable: true,
                enumerable: true,
                configurable: true
            });

            Ext.Ajax.request({
                timeout : 60000,
                url: cUrl,

                params: xParam,

                success: function (response) {
                    result = Ext.decode(response.responseText);
                    me.onOpenUrl(result.pathFile);
                },

                failure: function (response) {
                    me.app.onError('No se pueden cargar los datos');
                },

                callback : function (response) {
                    if (!Ext.isEmpty(vMask)) {
                        vMask.el.unmask();
                    }
                }
            });
        }
    }
});
