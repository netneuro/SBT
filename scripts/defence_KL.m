function [kl_divergence] = defence_KL(p, q)

global bin
figure
h_p = histogram(p, bin);
hold on
h_q = histogram(q, bin);

normal_p = h_p.Values / sum(h_p.Values);
normal_q = h_q.Values / sum(h_q.Values);

for i = 1:bin
    if normal_p(1,i) == 0
        normal_p(1,i) = 1e-10;
    end
    if normal_q(1,i) == 0
        normal_q(1,i) = 1e-10;
    end
end

kl_from_p_to_q = 0;
kl_from_q_to_p = 0;

for i = 1:bin
    kl_from_p_to_q = kl_from_p_to_q + (normal_p(1,i) * (log(normal_p(1,i) / normal_q(1,i))));
    kl_from_q_to_p = kl_from_q_to_p + (normal_q(1,i) * (log(normal_q(1,i) / normal_p(1,i))));
end

kl_divergence = (kl_from_p_to_q + kl_from_q_to_p);
close(gcf);

end

