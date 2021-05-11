--A naïve implementation of Xuedong Luo's prime sieve in pure Lua

--Acknowledgments to Thorkil Naur for the feedback

--See "A practical sieve algorithm finding prime numbers":
--https://dl.acm.org/doi/10.1145/62065.62072

--See discussion here:
--http://lua-users.org/lists/lua-l/2020-12/msg00032.html
--http://lua-users.org/lists/lua-l/2021-05/msg00022.html

local math   = math
local floor  = math.floor 
local sqrt   = math.sqrt

function primesieve(N)
    local result = {2, 3}
    if N < 2 then return {} end
    if N < 3 then return {2} end
    if N < 4 then return {2, 3} end
    local c, k, t, q, M, S
    c = 0
    k = 1 
    t = 2
    q = floor(sqrt(N)/3)
    M = N // 3
    S = {}
    local step = 2
    local first = 5
    while first <= N do
        S[#S+1] = first 
        first = first + step
        step = 6 - step
    end
    for i = 1, q, 1 do
        k = 3 - k 
        c = c + 4*k*i
        local j = c
        local ij = 2*i*(3-k)+1
        t = t + 4*k
        if S[i] ~= 0 then
            while j <= M do
                S[j] = 0
                j = j + ij
                ij = t - ij
            end
        end
    end
    for i = 1, #S do
        if S[i] > 0 then
            result[#result + 1] = S[i] 
        end
    end
    return result
end
