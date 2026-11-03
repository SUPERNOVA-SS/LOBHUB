local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- استخدام الذاكرة العامة (getgenv) لكي يبقى السكربت يحفظ مكانك بدقة حتى لو شغلته أكثر من مرة
getgenv().LastGroundCFrame = getgenv().LastGroundCFrame or nil

-- 1. حلقة مراقبة الخلفية (تعمل دائماً لحفظ آخر أرض لمستها)
if not getgenv().AntiFlyInitialized then
    getgenv().AntiFlyInitialized = true
    
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if root and hum then
                
                if hum.FloorMaterial ~= Enum.Material.Air then
                    getgenv().LastGroundCFrame = root.CFrame
                end
            end
        end
    end)
    print("تم تفعيل نظام حفظ الأرضية في الخلفية بنجاح!")
end

-- 2. كود الإرجاع الفوري (يعمل فور تنفيذك للسكربت ليرجعك مكانك غصب عن أي أحد)
local function snapBackToGround()
    local char = LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if root and getgenv().LastGroundCFrame then
            if hum then
                hum.PlatformStand = false
                hum.Sit = false
            end
            
            workspace.CurrentCamera.CameraSubject = hum
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            
            
            root.Velocity = Vector3.new(0, 0, 0)
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            
          
            root.CFrame = getgenv().LastGroundCFrame
            print("تم إرجاعك لآخر مكان وقفت فيه على الأرض قسراً!")
        else
            print("لم يتم تسجيل أرضية بعد، قف على الأرض لثانية واحدة لتسجيل المكان.")
        end
    end
end

-- تشغيل أمر العودة فوراً عند تنفيذ السكربت
snapBackToGround()
