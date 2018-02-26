cd ..
cd Stimuli
fid = fopen('Face.txt','wt');
fprintf(fid,'Images/FaceImages/face%d.jpg\n', 0:359);
fclose(fid);