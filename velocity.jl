"""

velocity(coordinates, gamma)

"""

function velocity(coordinates, gamma)

        r, v1 = zeros(3,4,4), zeros(3,4,4)      # initialize the distance and velocity arrays
        n = length(coordinates[1,:])            # number of points
        for i = 1:n, j = 1:n                    # i is the point being affected, j is the point doing the affecting
                r[:,j,i] = coordinates[:,i] - coordinates[:,j]  # the distances between each point, organized into a 3x4x4 array
                if i != j
                        v1[:,j,i] = cross(gamma[:,j],r[:,j,i]) / (2*pi*norm(r[:,j,i],2)^2)      # velocity of point j on point i
                else
                        v1[:,j,i] = [0;0;0]     # vortices do not induce a velocity on themselves
                end
        end                                     # the velocity vectors are now organized into a 3x4x4 array
        velocitysum = sum(v1, dims = 2) # the total velocity of a point is the sum of the velocities induced from each of the vortices
        return [velocitysum[:,:,1] velocitysum[:,:,2] velocitysum[:,:,3] velocitysum[:,:,4]]

end
