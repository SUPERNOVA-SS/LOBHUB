-- ينقلك غصب عن اي ادمي

local Players = game:GetService("Players")

local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer



pcall(function()

    local character = LocalPlayer.Character

    if character then

        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        local humanoid = character:FindFirstChildOfClass("Humanoid")

       



        if humanoid then

            humanoid.PlatformStand = false

            humanoid.Sit = false

        end

       

        Workspace.CurrentCamera.CameraSubject = humanoid

        Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

       

       

        local spawnPosition = Vector3.new(0, 5, 0)

        for _, obj in ipairs(Workspace:GetDescendants()) do

            if obj:IsA("SpawnLocation") then

                spawnPosition = obj.Position + Vector3.new(0, 3, 0)

                break

            end

        end

       

       

        if humanoidRootPart then

            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)

            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

            humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

           

            -- النقل الإجباري

            humanoidRootPart.CFrame = CFrame.new(spawnPosition)

        end

    end

end)
