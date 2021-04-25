local env = getgenv(); do
    env.constants = {
        c3new = Color3.new;
    };
    env.Math = {
        randint = math.random;
        floor = math.floor;
    };
    env.Color = {};
    env.Requests = {};
    env.Hook = {};
end
local constants = env.constants

function env.Color.RandomC3()
    local r = Math.randint(0,255)
    local g = Math.randint(0,255)
    local b = Math.randint(0,255)
    return constants.c3new(r,g,b)
end

function env.Math.round(num, decimal)
    return constants.floor(num + (num < 0 and -0.5 or 0.5))
end

function env.Math.GetDistance(p1, p2)
    return (p1 - p2).magnitude
end

function Requests.new(url, headers)
    assert(url, 'Missing required param "url".')
    
    local Request, self, Closed = {
        Url = url,
        Headers = headers or {}
    }, {Response = {}}, false
    
    function self:Send()
        assert(not Closed, 'Request is closed.')
        local Response = syn.request(Request)
        self.Response = Response
        return Response
    end
    
    function self:GetLastResponse()
        return self.Response 
    end
    
    function self:Close()
        assert(not Closed, 'Request is closed.')
        Closed = true
    end
    
    return self
end

return env
