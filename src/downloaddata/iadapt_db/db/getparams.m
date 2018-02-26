function getparams( sftpPassword, dbParamDir, localParamDir )

% Give permissions to read, write to, and execute scripts
system('chmod u+rwx getParams.sh');
system(['./getParams.sh ' sftpPassword ' ' dbParamDir ' ' localParamDir]);
