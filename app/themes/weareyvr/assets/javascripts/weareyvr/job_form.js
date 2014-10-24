$('input[type=radio]').click(function() { 
    $("#job_job_type").val('');
    $("#job_job_type").prop("disabled",true);

    if($(this).attr('id') == 'job_job_type_other') {
        $("#job_job_type").prop("disabled",false);
    }
});