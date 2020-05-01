# leapfrog Onboarding
# Author: Wesley Holt
# Date: 4/29/2020

#---PACKAGES AND FUNCTIONS---
    using LinearAlgebra
    using Plots
    include("velocity.jl")

#---INPUT PARAMETERS---
    gamma = [0 0 0 0; 0 0 0 0; -1 1 1 -1]               # velocity field vector, each column is for a different point
    h = .01                                            # time step
    initialcoordinates = [0 0 1 1; -.5 .5 .5 -.5; 0 0 0 0] # starting point

#---SETUP---
    t = range(0, length = 4000, step = h)                    # time stamps
    coordinates, v = zeros(3,4,length(t) + 1), zeros(3,4,length(t))  # initialize coordinate vector
    coordinates[:,:,1] = initialcoordinates

#---CALCULATE NEW COORDINATES STEP-BY-STEP---
    for i = 1:length(t)
        v[:,:,i] = velocity(coordinates[:,:,i], gamma)         # find the velocity of each point
        coordinates[:,:, i + 1] = coordinates[:,:,i] + v[:,:,i].*h  # estimate the new coordinates after one time step
    end

#---PLOT THE RESULT---
    plot(coordinates[1,1,:], coordinates[2,1,:], title = "Leapfrogging Vortex Rings", legend = false, tickfontsize = 10, color = :blue, linewidth = 3, size = (600,200))#,  xlim = (0,12), ylim = (-0.85, 0.85), size = (600,200))
    plot!(coordinates[1,2,:], coordinates[2,2,:], color = :blue, linewidth = 3)
    plot!(coordinates[1,3,:], coordinates[2,3,:], color = :red, linewidth = 3)
    plot!(coordinates[1,4,:], coordinates[2,4,:], color = :red, linewidth = 3)

#---PLOT VELOCITY VS X-DISPLACEMENT---
    # plot(coordinates[1,1,1:end-1], v[1,1,:], title = "Velocity vs. x-displacement", legend = false, xlabel = "x-position", ylabel = "velocity", tickfontsize = 10, color = :blue, linewidth = 3, linestyle = :dot)
    # plot!(coordinates[1,3,1:end-1], v[1,3,:], tickfontsize = 10, color = :red, linewidth = 3, linestyle = :dot)

#---CREATE A GIF ANIMATION---
    # @gif for i = 1:length(t)
    #     plot(coordinates[1,1,1:i], coordinates[2,1,1:i], title = "Leapfrogging Vortices in 2D", legend = false, tickfontsize = 10, color = :blue, linewidth = 1, xlim = (minimum(coordinates[1,:,:]), maximum(coordinates[1,:,:])), ylim = (minimum(coordinates[2,:,:]), maximum(coordinates[2,:,:])))
    #     plot!(coordinates[1,2,1:i], coordinates[2,2,1:i], color = :blue, linewidth = 1)
    #     plot!(coordinates[1,3,1:i], coordinates[2,3,1:i], color = :red, linewidth = 1)
    #     plot!(coordinates[1,4,1:i], coordinates[2,4,1:i], color = :red, linewidth = 1)
    #     plot!([coordinates[1,1,i];coordinates[1,2,i]],[coordinates[2,1,i]; coordinates[2,2,i]], color = :blue, linewidth = 10)
    #     plot!([coordinates[1,3,i];coordinates[1,4,i]],[coordinates[2,3,i]; coordinates[2,4,i]], color = :red, linewidth = 10)
    # end every 20
