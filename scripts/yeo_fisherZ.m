% 5 Bahman 98
% 17 YEO networks


%% split 400 ROI fisherZ into 17 yea networks:
for i=1:25
 for j=1:400       
        % 1. visual centeral
        z_visCent_l(1:12,1:12) = Z_individuals_asd_6_9_dis{1,i}(1:12,1:12);
        z_visCent_r(201:212,201:212) = Z_individuals_asd_6_9_dis{1,i}(201:212,201:212);
        
        z_individuals_visCent{1,i} = [z_visCent_l, z_visCent_r];
        
    
         % 2. peripheral centeral
        for j=13:24
            z_visPeri_l(:,j-12) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=213:223
            z_visPeri_r(:,j-212) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_visPeri{1,i} = [z_visPeri_l, z_visPeri_r];
       
        
        % 3. somato motor A
        for j=25:43
            z_somMotA_l(:,j-24) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=224:243
            z_somMotA_r(:,j-223) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_somMotA{1,i} = [z_somMotA_l, z_somMotA_r];

        
         % 4. somato motor B
        for j=44:59
            z_somMotB_l(:,j-43) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=244:258
            z_somMotB_r(:,j-243) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_somMotB{1,i} = [z_somMotB_l, z_somMotB_r];        

        
        % 5. dorsal attention A
        for j=60:72
            z_dorsAttnA_l(:,j-59) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=259:272
            z_dorsAttnA_r(:,j-258) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_dorsAttnA{1,i} = [z_dorsAttnA_l, z_dorsAttnA_r];

        
         % 6. dorsal attention B
        for j=73:85
            z_dorsAttnB_l(:,j-72) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=273:284
            z_dorsAttnB_r(:,j-272) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_dorsAttnB{1,i} = [z_dorsAttnB_l, z_dorsAttnB_r];

        
        % 7. salience A
        for j=86:100
            z_salA_l(:,j-85) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=285:303
            z_salA_r(:,j-284) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end

        z_individuals_salA{1,i} = [z_salA_l, z_salA_r];
              

         % 8. salience B
        for j=101:108
            z_salB_l(:,j-100) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=304:312
            z_salB_r(:,j-303) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_salB{1,i} = [z_salB_l, z_salB_r]; 

        
        % 9. limbic B
        for j=109:113
            z_limbicB_l(:,j-108) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=313:318
            z_limbicB_r(:,j-312) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_limbicB{1,i} = [z_limbicB_l, z_limbicB_r];

        
         % 10. limbic A
        for j=114:120
            z_limbicA_l(:,j-113) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=319:324
            z_limbicA_r(:,j-318) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_limbicA{1,i} = [z_limbicA_l, z_limbicA_r];

        
        % 11. Cont A
        for j=121:133
            z_contA_l(:,j-120) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=325:335
            z_contA_r(:,j-324) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_contA{1,i} = [z_contA_l, z_contA_r];

        
         % 12. Cont B
        for j=134:143
            z_contB_l(:,j-133) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=336:350
            z_contB_r(:,j-335) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_contB{1,i} = [z_contB_l, z_contB_r];        

        
        % 13. Cont C
        for j=144:148
            z_contC_l(:,j-143) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=351:357
            z_contC_r(:,j-350) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_contC{1,i} = [z_contC_l, z_contC_r];


         % 14. DMN A
        for j=149:166
            z_dmnA_l(:,j-148) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=358:373
            z_dmnA_r(:,j-357) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_dmnA{1,i} = [z_dmnA_l, z_dmnA_r];

        
        % 15. DMN B
        for j=167:187
            z_dmnB_l(:,j-166) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=374:384
            z_dmnB_r(:,j-373) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_dmnB{1,i} = [z_dmnB_l, z_dmnB_r];

        
         % 16. BMN C
        for j=188:194
            z_dmnC_l(:,j-187) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=385:390
            z_dmnC_r(:,j-384) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_dmnC{1,i} = [z_dmnC_l, z_dmnC_r];        

        
         % 17. temporo parietal
        for j=195:200
            z_tempPar_l(:,j-194) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        for j=391:400
            z_tempPar_r(:,j-390) = Z_individuals_asd_6_9_dis{1,i}(:,j);
        end
        
        z_individuals_tempPar{1,i} = [z_tempPar_l, z_tempPar_r];        
        
 end
end
