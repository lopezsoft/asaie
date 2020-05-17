Ext.define('Admin.view.academico.container.AcademicContainerView',{
    extend  : 'Ext.container.Container',
    controller  : 'academico',
    alias       : 'widget.academicContainerView',
    xtype       : 'academicContainerView',
    reference   : 'academicContainerView',
    layout      : 'responsivecolumn' ,
    items   : [
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Inscripción y matriculas',
                    iconCls : 'fas fa-user-graduate',
                    handler : 'onViewIscripciones'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Áreas académicas',
                    iconCls : 'x-fa fa-table',
                    handler : 'onCreateAreas'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Asignaturas académicas',
                    iconCls : 'x-fa fa-table',
                    handler : 'onCreateAsignaturas'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Carga académica',
                    handler : 'onCreateCarga',
                    iconCls: 'fas fa-chalkboard-teacher'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Notas reportadas',
                    handler : 'onNotasReportadas',
                    iconCls: 'fas fa-chalkboard-teacher'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Notas académicas',
                    handler : 'onNotasAcademicas',
                    iconCls: 'fas fa-chalkboard-teacher'
                }
            ]
        },
		{
			xtype   : 'containerButton',
			items   : [
				{
					xtype   : 'buttonPanel',
					text    : 'Transferir Notas académicas',
					handler : 'onTransferirNotasView',
                    iconCls: 'fas fa-chalkboard-teacher'
				}
			]
		},
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype: 'buttonPanel',
                    text: 'Contancias de estudio',
                    handler: 'onConstancias'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Certificados periódicos',
                    handler : 'onCertificados'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype: 'buttonPanel',
                    text: 'Cuadro de honor',
                    handler: 'onCuadroHonor'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype: 'buttonPanel',
                    text: 'Mover Estudiantes',
                    handler: 'onMoverEstudiantes'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype: 'buttonPanel',
                    text: 'Informes',
                    iconCls : 'x-fa fa-print',
                    handler : 'onViewReportes'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Ficha Observador',
                    handler : 'onFichaObservador'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Acceso Estudiantes',
                    iconCls : 'x-fa fa-key',
                    tooltip : 'Permite generar o reestablecer los datos de acceso al personal estudiantíl.',
                    handler : function (btn) {
                        var
                            me  = Admin.getApplication(),
                            ts  = btn.up('container').up('container'),
                            url = Global.getUrlBase()+'academic/get_update_pass_est';
                        ts.mask();
                        Ext.Ajax.request({
                            url: url,
                            success: function(response, opts) {
                                me.showResult('Se ha realizado el proceso correntamente');
                            },
                            failure: function(response, opts) {
                                me.showResult('No se ha realizado el proceso correntamente');
                            },callback : function(){
                                ts.unmask();
                            }
                        });
                    }
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Actividades de apoyo',
                    iconCls : 'x-fa fa-cog',
                    handler : 'onActividadesApoyo'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items: [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Mayúsculas  Logros Indicadores',
                    handler : 'onMayus',
                    iconCls : 'x-fa fa-text-width'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Pre-Matricula Nuevos',
                    iconCls : 'xi-student-24',
                    disabled: true,
                    handler : 'onViewPreMatNuevos'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Pre-Matricula Antiguos',
                    iconCls : 'xi-student-24',
                    disabled: true,
                    handler : 'onViewPreMatViejos'
                }
            ]
        }
    ]
});
