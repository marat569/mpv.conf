local function pq_eotf(x)
    if not x then
        return x;
    end

    local PQ_M1 = 2610.0 / 4096 * 1.0 / 4
    local PQ_M2 = 2523.0 / 4096 * 128
    local PQ_C1 = 3424.0 / 4096
    local PQ_C2 = 2413.0 / 4096 * 32
    local PQ_C3 = 2392.0 / 4096 * 32

    x = x ^ (1.0 / PQ_M2)
    x = math.max(x - PQ_C1, 0.0) / (PQ_C2 - PQ_C3 * x)
    x = x ^ (1.0 / PQ_M1)
    x = x * 10000.0

    return x
end

mp.add_key_binding('n', function() 
	local pq = mp.get_property_native('video-out-params/max-pq-y')
	if not pq then
		return
	end
	mp.commandv('show-text', string.format("%.2f cd/m² (%.2f%% PQ)", pq_eotf(pq), pq * 100))
end)